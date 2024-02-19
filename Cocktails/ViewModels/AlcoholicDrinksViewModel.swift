import Foundation
import SwiftUI

class AlcoholicDrinksViewModel: ItemListViewable {
    var networking: CocktailsNetworking?
    
    var isLoading: Bool = true
    @Published var items: [Item] = []
    
    //MARK: Dependency injection... Abstracts not concretes
    init(networking: CocktailsNetworking) {
        self.networking = networking
        setUpData()
    }
    
    func setUpData() {
        networking?.fetchJSON(drinkType: .alcoholic) { (result: Result<AlcoholicDrinks, NetworkError>) in
            switch result {
            case .success(let alcoholicDrinks):
                DispatchQueue.main.async {
                    self.items = alcoholicDrinks.drinks.map({ drink in
                        Item( id: drink.idDrink,
                              drinkName: drink.strDrink,
                              glass: nil,
                              instructions: nil,
                              image: drink.strDrinkThumb,
                              category: "Alcoholic",
                              isFavorite: false)
                    })
                }
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
    }
}
