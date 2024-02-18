import Foundation
import RealmSwift

class SelectedDrinkViewModel: ObservableObject {
    var networking: CocktailsNetworking
    @Published var selectedDrink: Drink?
    @Published var isLoading: Bool = false
    @ObservedRealmObject var favoriteDrink: FavoriteDrink = FavoriteDrink()
    
    init(selectedDrink: Drink? = nil, networking: CocktailsNetworking) {
        self.networking = networking
        self.selectedDrink = selectedDrink
        if let selectedDrink = self.selectedDrink {
            self.setUpDrink(with: selectedDrink)
        }
    }
    
    
    func setUpDrink(with selectedDrink: Drink) {
        self.isLoading = true
        if !(selectedDrink.isFavorite ?? false) {
            fetchDrinkDetails(selectedDrink)
            
        } else {
            setupDrinkFromRealm(selectedDrink)
        }
    }
    
    private func fetchDrinkDetails(_ selectedDrink: Drink) {
        networking.fetchJSON(drinkType: .detailedDrink, specificDrinkID: selectedDrink.id) { (result: Result<SearchedDrinkDetails, NetworkError>) in
            switch result {
            case .success(let searchedDrink):
                if let searchedDrink = searchedDrink.drinks.first {
                    DispatchQueue.main.async {
                        self.selectedDrink = Drink(id: searchedDrink.idDrink,
                                                   drinkName: searchedDrink.strDrink,
                                                   glass: searchedDrink.strGlass,
                                                   instructions: searchedDrink.strInstructions,
                                                   image: searchedDrink.strDrinkThumb,
                                                   category: searchedDrink.strCategory,
                                                   isFavorite: false)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupDrinkFromRealm(_ selectedDrink: Drink) {
        self.favoriteDrink.drinkName = selectedDrink.drinkName
        self.favoriteDrink.isFavourite = true
        self.favoriteDrink.image = selectedDrink.image
        self.favoriteDrink.category = selectedDrink.category
        self.favoriteDrink.glass = selectedDrink.glass
        self.favoriteDrink.instructions = selectedDrink.instructions
    }
}
