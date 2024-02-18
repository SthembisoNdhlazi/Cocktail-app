import Foundation
import RealmSwift

class FavoriteDrinksViewModel: ItemListViewable {
    @Published var items: [Drink] = []
    var networking: CocktailsNetworking? = nil
    
    var isLoading: Bool = true
    var realm = RealmManager.sharedInstance
    @ObservedResults(FavoriteDrink.self) var favouriteDrinks
    
    init() {
        setUpData()
    }
    
    func setUpData() {
//        self.items = self.realm.favouriteDrinks
        self.items = self.$favouriteDrinks.wrappedValue.map({ Drink(id: $0.id,
                                                     drinkName: $0.drinkName,
                                                     glass: $0.glass,
                                                     instructions: $0.instructions,
                                                     image: $0.image,
                                                     category: $0.category,
                                                     isFavorite: $0.isFavourite) })
        self.isLoading = false
    }
}
