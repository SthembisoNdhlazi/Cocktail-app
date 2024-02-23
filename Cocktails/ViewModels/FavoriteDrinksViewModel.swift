import Foundation
import RealmSwift
import InjectPropertyWrapper
import ReusableComponents
import Combine

class FavoriteDrinksViewModel: ItemListViewable {
    var networking: CocktailsNetworking? = nil
    
    var isLoading: Bool = true
    @Published var items: [Item] = []
    @Inject private var realm: any Persistable
    //Use this to update the items variable when realm favorites update
    private var notificationToken: NotificationToken?
    
    init() {
        setUpData()
        observeRealmChanges()
    }
    
    func setUpData() {
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
    // we use that token to observe changes to favoriteDrinks in realm
    private func observeRealmChanges() {
        let realm = try! Realm()
        let favouriteDrinks = realm.objects(FavoriteDrink.self)
        notificationToken = favouriteDrinks.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.items = favouriteDrinks.map({ Item(id: $0.id,
                                                        drinkName: $0.drinkName,
                                                        glass: $0.glass,
                                                        instructions: $0.instructions,
                                                        image: $0.image,
                                                        category: $0.category,
                                                        isFavorite: $0.isFavourite) })
            case .error:
                print("Error updating drinks")
                break
            }
        }
    }
}
