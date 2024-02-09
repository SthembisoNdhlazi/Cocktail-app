import Foundation
import SwiftUI

class AlcoholicDrinksViewModel: ItemListViewable {
    var isLoading: Bool = true
    

    private var networking = CocktailsServiceCalls()
    @Published var items: [Drink] = []
    
    init() {
        setUpData()
    }
    
    func setUpData() {
        networking.getAlcoholicDrinks { drinks in
            for drink in drinks.drinks {
                self.items.append(Drink(id: drink.idDrink ,drinkName: drink.strDrink, image: drink.strDrinkThumb,category: "Alcoholic"))
            }
            self.isLoading = false
        }
        
    }
}
