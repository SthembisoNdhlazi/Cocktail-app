import Foundation
import RealmSwift
import InjectPropertyWrapper
import ReusableComponents

protocol SelectedItem: ObservableObject {
    var selectedItem: Item? { get set }
    var favoriteDrink: FavoriteDrink { get set}
}

class SelectedItemViewModel: SelectedItem {
    @Published var selectedItem: Item?
    @Published var isLoading: Bool = false
    @ObservedRealmObject var favoriteDrink: FavoriteDrink = FavoriteDrink()
    @Inject var realm: any Persistable
    @Inject var drinksRepository: DrinksRepository
    
    init(selectedItem: Item? = nil) {
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
        drinksRepository.fetchDrinks(drinktype: .detailedDrink, selectedDrinkID: selectedDrink.id) { item in
            DispatchQueue.main.async {
                self.selectedItem = item.first
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
