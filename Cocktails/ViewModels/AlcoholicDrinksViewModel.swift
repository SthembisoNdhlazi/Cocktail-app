import Foundation
import ReusableComponents
import InjectPropertyWrapper
import RealmSwift

class AlcoholicDrinksViewModel: ItemListViewable {
    var isLoading: Bool = true
    @Published var items: [Item] = []
    private var drinksRepository: DrinksRepository
    private var notificationToken: NotificationToken?
    
    //MARK: Dependency injection... Abstracts not concretes
    init(drinksRepository: DrinksRepository) {
        //        self.networking = networking
        self.drinksRepository = drinksRepository
        setUpData()
        observeRealmChanges()
    }
    
    func setUpData() {
        drinksRepository.fetchDrinks(drinktype: .alcoholic) { drinks in
            self.items = drinks
            self.isLoading = false
        }
    }
    
    private func observeRealmChanges() {
        let realm = try! Realm()
        let favouriteDrinks = realm.objects(FavoriteDrink.self)
        notificationToken = favouriteDrinks.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                for drink in favouriteDrinks {
                    if let drinkIndexFromRealm = self.items.firstIndex(where: {$0.drinkName.lowercased() == drink.drinkName.lowercased()}) {
                        self.items[drinkIndexFromRealm] = Item(id: drink.id,
                                                               drinkName: drink.drinkName,
                                                               glass: drink.glass,
                                                               instructions: drink.instructions,
                                                               image: drink.image,
                                                               category: drink.category,
                                                               isFavorite: drink.isFavourite)
                    }
                }
            case .error:
                print("Error updating drinks")
                break
            }
        }
    }
}
