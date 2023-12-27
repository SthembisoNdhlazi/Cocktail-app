import Foundation

class SelectedDrinkViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
    private var selectedDrinkName: String = ""
    @Published var detailedDrink: Drink?
    @Published var isLoading: Bool = false
 
    func setUpDrink(with selectedDrink: Drink) {
        self.isLoading = true
        networking.searchForDrink(drinkName: selectedDrink.drinkName) { drink in
            if let searchedDrink = drink.drinks.first(where: {$0.strDrink.lowercased() == selectedDrink.drinkName.lowercased() }) {
                self.detailedDrink = Drink(id: searchedDrink.idDrink,
                                           drinkName: searchedDrink.strDrink,
                                           glass: searchedDrink.strGlass,
                                           instructions: searchedDrink.strInstructions,
                                           image: searchedDrink.strDrinkThumb,
                                           category: searchedDrink.strCategory, isFavorite: selectedDrink.isFavorite)
                self.isLoading = false
            }
        }
    }
    
}
