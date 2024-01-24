import Foundation
import RealmSwift

class SelectedDrinkViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
//    private var selectedDrinkName: String = ""
    @Published var selectedDrink: Drink?
    @Published var isLoading: Bool = false
    @ObservedRealmObject var favoriteDrink: FavoriteDrink = FavoriteDrink()
    
    init(selectedDrink: Drink? = nil) {
        self.selectedDrink = selectedDrink
        if let selectedDrink = self.selectedDrink {
            setUpDrink(with: selectedDrink)
        }
    }
    
    func setUpDrink(with selectedDrink: Drink) {
        self.isLoading = true
        if !(selectedDrink.isFavorite ?? false) {
            networking.searchForDrink(drinkName: selectedDrink.drinkName) { drink in
                if let searchedDrink = drink.drinks.first(where: {$0.strDrink.lowercased() == selectedDrink.drinkName.lowercased() }) {
                    self.selectedDrink = Drink(id: searchedDrink.idDrink,
                                               drinkName: searchedDrink.strDrink,
                                               glass: searchedDrink.strGlass,
                                               instructions: searchedDrink.strInstructions,
                                               image: searchedDrink.strDrinkThumb,
                                               category: searchedDrink.strCategory,
                                               isFavorite: selectedDrink.isFavorite)
                    self.isLoading = false
                }
            }
        } else {
            self.favoriteDrink.drinkName = selectedDrink.drinkName
            self.favoriteDrink.isFavourite = true
            self.favoriteDrink.image = selectedDrink.image
            self.favoriteDrink.category = selectedDrink.category
            self.favoriteDrink.glass = selectedDrink.glass
            self.favoriteDrink.instructions = selectedDrink.instructions
        }
    }
    
}
