import Foundation
import SwiftUI
import SideBarComponent

class SideBarDataProvider: SideBarConfigurable {
    let networking: CocktailsNetworking
    @Published var categories: [SideBarViewModel] = []
    
    init(networking: CocktailsNetworking) {
        self.networking = networking
        self.categories = [
            //        SideBarViewModel(category: "Search",
            //                         view: AnyView(Text("Search goes here"))),
            
            SideBarViewModel(category: "Non alcoholic",
                             view: AnyView(ItemListView(dataProvider: NonAlcoholicDrinksViewModel(networking: networking)))),
            
            SideBarViewModel(category: "My favorites",
                             view: AnyView(FavoritesView())),
            
            SideBarViewModel(category: "Alcoholic",
                             view: AnyView(ItemListView(dataProvider: AlcoholicDrinksViewModel(networking: networking))))
        ]
    }
}
