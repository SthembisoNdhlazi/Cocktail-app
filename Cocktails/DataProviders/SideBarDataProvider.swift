import Foundation
import SwiftUI
import SideBarComponent
import Swinject

class SideBarDataProvider: SideBarConfigurable {
    let networking: CocktailsNetworking
    @Published var categories: [SideBarViewModel] = []
    
    init(networking: CocktailsNetworking) {
        self.networking = networking
        self.categories = [
            //        SideBarViewModel(category: "Search",
            //                         view: AnyView(Text("Search goes here"))),
            
            SideBarViewModel(category: "Non alcoholic",
                             view: AnyView(ItemListView(dataProvider: Container.shared.resolve((any ItemListViewable).self, name: RegistrationName.nonAlcoholicDrinksViewModel) as! NonAlcoholicDrinksViewModel))),
            
            SideBarViewModel(category: "My favorites",
                             view: AnyView(FavoritesView(favoriteDrinksVM: Container.shared.resolve((any ItemListViewable).self, name: RegistrationName.favoriteDrinksViewModel) as! FavoriteDrinksViewModel))),
            
            SideBarViewModel(category: "Alcoholic",
                             view: AnyView(ItemListView(dataProvider: Container.shared.resolve((any ItemListViewable).self, name: RegistrationName.alcoholicDrinksViewModel) as! AlcoholicDrinksViewModel)))
        ]
    }
}
