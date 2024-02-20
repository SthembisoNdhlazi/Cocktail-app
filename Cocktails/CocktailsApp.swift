import SwiftUI
import Swinject
import InjectPropertyWrapper
import ReusableComponents
import SideBarComponent

@main
struct CocktailsApp: App {
    
    init () {
        InjectSettings.resolver = Container.shared
        setUpDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            SidebarComponent(dataProvider: Container.shared.resolve((any SideBarConfigurable).self) as! SideBarDataProvider, title: "Cocktails")
        }
    }
    
    private func setUpDependencies() {
        Container.shared.register(CocktailsNetworking.self) { _ in
            CocktailsServiceCalls()
        }
        
        Container.shared.register((any SideBarConfigurable).self) { resolver in
            SideBarDataProvider(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register(Persistable.self) { _ in
            RealmManager()
        }.inObjectScope(.container)
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.alcoholicDrinksViewModel) { resolver in
            AlcoholicDrinksViewModel(networking: resolver.resolve(CocktailsNetworking.self)!) as any ItemListViewable
        }
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.nonAlcoholicDrinksViewModel) { resolver in
            NonAlcoholicDrinksViewModel(networking: resolver.resolve(CocktailsNetworking.self)!) as any ItemListViewable
        }
        
        Container.shared.register((any SelectedItem).self, name: RegistrationName.selectedItemViewModel) { resolver in
            SelectedItemViewModel(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.favoriteDrinksViewModel) { resolver in
            FavoriteDrinksViewModel() as any ItemListViewable
        }
        
        //MARK: Bind all the views, including the selectedItemView and ItemListView
        Container.shared.register(ItemDetailView.self, name: RegistrationName.singleDrinkView) { resolver, item in
            SingleItemView(selectedItem: item)
        }
        
        Container.shared.register(AnyView.self, name: RegistrationName.alcoholicDrinksView) { resolver in
            let provider = resolver.resolve((any ItemListViewable).self, name: RegistrationName.alcoholicDrinksViewModel)
            
            return AnyView (ItemListView(dataProvider: provider as! AlcoholicDrinksViewModel) { item in
                resolver.resolve(ItemDetailView.self, name: RegistrationName.singleDrinkView, argument: item) as! SingleItemView
            })
        }
        
        Container.shared.register((AnyView.self), name: RegistrationName.nonAlcoholicView) { resolver in
            let provider = resolver.resolve((any ItemListViewable).self, name: RegistrationName.nonAlcoholicDrinksViewModel)
            
            return AnyView (ItemListView(dataProvider: provider as! NonAlcoholicDrinksViewModel) { item in
                resolver.resolve(ItemDetailView.self, name: RegistrationName.singleDrinkView, argument: item) as! SingleItemView
            })
        }
        
    }
}

public enum RegistrationName {
    static let selectedItemViewModel = "SelectedItemViewModel"
    static let favoriteDrinksViewModel = "FavoriteDrinksViewModel"
    static let nonAlcoholicDrinksViewModel = "NonAlcoholicDrinksViewModel"
    static let alcoholicDrinksViewModel = "AlcoholicDrinksViewModel"
    static let singleDrinkView = "SingleDrinkView"
    static let nonAlcoholicView = "NonAlcoholicView"
    static let alcoholicDrinksView = "AlcoholicDrinksView"
    static let favoriteDrinksView = "FavoriteDrinksView"
}
