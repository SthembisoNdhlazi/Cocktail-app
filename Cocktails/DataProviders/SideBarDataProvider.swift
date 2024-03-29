import Foundation
import SwiftUI
import SideBarComponent
import Swinject
import ReusableComponents

class SideBarDataProvider: SideBarConfigurable {
    let networking: CocktailsNetworking
    @Published var categories: [SideBarViewModel] = []
    
    init(networking: CocktailsNetworking) {
        self.networking = networking
        self.categories = [
            //        SideBarViewModel(category: "Search",
            //                         view: AnyView(Text("Search goes here"))),
            
            SideBarViewModel(category: DrinkCategories.nonAlcoholic.rawValue,
                             view: Container.shared.resolve(AnyView.self, name: RegistrationName.nonAlcoholicView)!),
            
            SideBarViewModel(category: DrinkCategories.favourites.rawValue,
                             view: Container.shared.resolve(AnyView.self, name: RegistrationName.favoriteDrinksView)!),
            
            SideBarViewModel(category: DrinkCategories.alcoholic.rawValue,
                             view: Container.shared.resolve(AnyView.self, name: RegistrationName.alcoholicDrinksView)!)
        ]
    }
}
