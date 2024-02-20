import Foundation
import RealmSwift
import InjectPropertyWrapper
import ReusableComponents

protocol SelectedItem: ObservableObject {
    var networking: CocktailsNetworking {get set}
    var selectedItem: Item? { get set }
    var favoriteDrink: FavoriteDrink { get set}
}

class SelectedItemViewModel: SelectedItem {
    var networking: CocktailsNetworking
    @Published var selectedItem: Item?
    @Published var isLoading: Bool = false
    @ObservedRealmObject var favoriteDrink: FavoriteDrink = FavoriteDrink()
    @Inject var realm: Persistable
    
    init(selectedItem: Item? = nil, networking: CocktailsNetworking) {
        self.networking = networking
        self.selectedItem = selectedItem
        if let selectedItem = self.selectedItem {
            self.setUpDrink(with: selectedItem)
        }
    }
    
    
    func setUpDrink(with selectedDrink: Item) {
        self.isLoading = true
        if !(selectedDrink.isFavorite ?? false) {
            fetchDrinkDetails(selectedDrink)
            
        } else {
            setupDrinkFromRealm(selectedDrink)
        }
    }
    
    private func fetchDrinkDetails(_ selectedDrink: Item) {
        networking.fetchJSON(drinkType: .detailedDrink, specificDrinkID: selectedDrink.id) { (result: Result<SearchedDrinkDetails, NetworkError>) in
            switch result {
            case .success(let searchedDrink):
                if let searchedDrink = searchedDrink.drinks.first {
                    self.selectedItem = Item(id: searchedDrink.idDrink,
                                             drinkName: searchedDrink.strDrink,
                                             glass: searchedDrink.strGlass,
                                             instructions: searchedDrink.strInstructions,
                                             image: searchedDrink.strDrinkThumb,
                                             category: searchedDrink.strCategory,
                                             isFavorite: false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupDrinkFromRealm(_ selectedDrink: Item) {
        self.favoriteDrink.drinkName = selectedDrink.drinkName
        self.favoriteDrink.isFavourite = true
        self.favoriteDrink.image = selectedDrink.image
        self.favoriteDrink.category = selectedDrink.category
        self.favoriteDrink.glass = selectedDrink.glass
        self.favoriteDrink.instructions = selectedDrink.instructions
    }
    
    //MARK: Move logic to selectedDrinkViewModel
    private func persistItem() {
        setUpFavoriteDrink()
        selectedItem?.isFavorite = true
        //        realm.save(drink: selectedDrinkViewModel.favoriteDrink)
        realm.save(object: favoriteDrink) { error in
            print(error)
        }
    }
    
    private func setUpFavoriteDrink() {
        favoriteDrink = FavoriteDrink(id: selectedItem?.id ?? "",
                                      drinkName: selectedItem?.drinkName ?? "",
                                      glass: selectedItem?.glass,
                                      instructions: selectedItem?.instructions,
                                      image: selectedItem?.image ?? "",
                                      category: selectedItem?.category,
                                      isFavourite: true)
    }
    
    func addOrDeleteFromDatabase (isFavorite: Bool?) {
        if let isFavorite {
            if isFavorite {
                setUpFavoriteDrink()
                removeFromRealm()
            } else {
                persistItem()
            }
        } else {
            persistItem()
        }
    }
    
    private func removeFromRealm() {
        selectedItem?.isFavorite = false
        realm.delete(object: favoriteDrink) { error in
            print(error)
        }
    }
}
