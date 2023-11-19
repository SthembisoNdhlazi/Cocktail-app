import Foundation

class SelectedDrinkViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
    private var selectedDrinkName: String = ""
    @Published var detailedDrink: Drink?
    @Published var isLoading: Bool = false
 
    func setUpDrink(with name: String) {
        self.isLoading = true
        networking.searchForDrink(drinkName: name) { drink in
            if let searchedDrink = drink.drinks.first(where: {$0.strDrink.lowercased() == name.lowercased() }) {
                self.detailedDrink = Drink(id: searchedDrink.idDrink, drinkName: searchedDrink.strDrink, glass: searchedDrink.strGlass, instructions: searchedDrink.strInstructions, image: searchedDrink.strDrinkThumb, category: searchedDrink.strCategory)
                self.isLoading = false
            }
        }
    }
}
