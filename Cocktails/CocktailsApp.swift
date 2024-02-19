import SwiftUI
import SideBarComponent
import Swinject
import InjectPropertyWrapper

@main
struct CocktailsApp: App {
    
    init () {
        InjectSettings.resolver = Container.shared
        setUpDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            //TODO: Get rid of this and just use SideBarComponent instead of landing view
            LandingView(view: AnyView(SidebarComponent(dataProvider: Container.shared.resolve((any SideBarConfigurable).self) as! SideBarDataProvider, title: "Cocktails")))
            
        }
    }
    
    private func setUpDependencies() {
        Container.shared.register(CocktailsNetworking.self) { _ in
            CocktailsServiceCalls()
        }
        
        Container.shared.register((any SideBarConfigurable).self) { resolver in
            SideBarDataProvider(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register(RealmManagable.self) { _ in
            RealmManager()
        }.inObjectScope(.container)
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.alcoholicDrinksViewModel) { resolver in
            AlcoholicDrinksViewModel(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.nonAlcoholicDrinksViewModel) { resolver in
            NonAlcoholicDrinksViewModel(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register((any SelectedItem).self, name: RegistrationName.selectedItemViewModel) { resolver in
            SelectedItemViewModel(networking: resolver.resolve(CocktailsNetworking.self)!)
        }
        
        Container.shared.register((any ItemListViewable).self, name: RegistrationName.favoriteDrinksViewModel) { resolver in
            FavoriteDrinksViewModel()
        }
    }
}

public enum RegistrationName {
    static let selectedItemViewModel = "SelectedItemViewModel"
    static let favoriteDrinksViewModel = "FavoriteDrinksViewModel"
    static let nonAlcoholicDrinksViewModel = "NonAlcoholicDrinksViewModel"
    static let alcoholicDrinksViewModel = "AlcoholicDrinksViewModel"
}
