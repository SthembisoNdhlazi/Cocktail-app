import Foundation
import SwiftUI

class AlcoholicDrinksViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
    @Published var allAlcoholicDrinks: [Drink] = []
    @Published var displayAlcoholicDrink:Drink = Drink(drinkName: "", glass: "", instructions: "", image: "", category: "")
    
    init() {
        getAlcoholicDrinks()
    }
    
    private func getAlcoholicDrinks() {
        networking.getAlcoholicDrinks { drinks in
            let randomDrink = drinks.drinks.randomElement()
            for drink in drinks.drinks {
                self.allAlcoholicDrinks.append( Drink(drinkName: drink.strDrink, image: drink.strDrinkThumb))

            }
            self.displayAlcoholicDrink = Drink(drinkName: randomDrink?.strDrink ?? "", image: randomDrink?.strDrinkThumb ?? "")
        }
    }
}
