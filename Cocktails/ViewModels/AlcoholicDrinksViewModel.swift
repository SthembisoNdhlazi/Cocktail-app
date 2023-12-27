import Foundation
import SwiftUI

class AlcoholicDrinksViewModel: ItemListViewable {
    var isLoading: Bool = true
    

    private var networking = CocktailsServiceCalls()
    @Published var items: [ItemListViewModel] = []
    
    init() {
        setUpData()
    }
    
    func setUpData() {
        networking.getAlcoholicDrinks { drinks in
            for drink in drinks.drinks {
                self.items.append(ItemListViewModel(imageURLString: drink.strDrinkThumb, title: drink.strDrink, subtitle: "Alcoholic"))
            }
            self.isLoading = false
        }
        
    }
}
