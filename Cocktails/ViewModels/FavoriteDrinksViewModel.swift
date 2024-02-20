import Foundation
import RealmSwift
import InjectPropertyWrapper
import ReusableComponents

class FavoriteDrinksViewModel: ItemListViewable {
    @Published var items: [Item] = []
    var networking: CocktailsNetworking? = nil
    
    var isLoading: Bool = true
    @Inject private var realm: Persistable
    
    init() {
        setUpData()
    }
    
    func setUpData() {
//        self.items = self.realm.favouriteDrinks
        DispatchQueue.main.async {
            self.items = self.realm.favouriteDrinks.map({ Item(id: $0.id,
                                                               drinkName: $0.drinkName,
                                                               glass: $0.glass,
                                                               instructions: $0.instructions,
                                                               image: $0.image,
                                                               category: $0.category,
                                                               isFavorite: $0.isFavourite) })
        }
        self.isLoading = false
    }
}
