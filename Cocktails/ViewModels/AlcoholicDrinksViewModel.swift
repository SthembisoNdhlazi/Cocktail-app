import Foundation
import SwiftUI

class AlcoholicDrinksViewModel: ObservableObject {
    private var networking = CocktailsServiceCalls()
    @Published var allAlcoholicDrinks: [Drink] = []
    
    init() {
        getAlcoholicDrinks()
    }
    
    private func getAlcoholicDrinks() {
        networking.getAlcoholicDrinks { drinks in
            for drink in drinks.drinks {
                self.allAlcoholicDrinks.append( Drink(drinkName: drink.strDrink, image: drink.strDrinkThumb))
                
            }
        }
    }
}
