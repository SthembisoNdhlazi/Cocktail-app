import Foundation
import SwiftUI
import SideBarComponent

class SideBarDataProvider: SideBarConfigurable {
    @Published var categories: [SideBarViewModel] = [
        SideBarViewModel(category: "Search", view: AnyView(Text("Search goes here"))),
        SideBarViewModel(category: "Non alcoholic", view: AnyView(ItemListView(dataProvider: NonAlcoholicDrinksViewModel()))),
        SideBarViewModel(category: "My favorites", view: AnyView(Text("Faves go here"))),
        SideBarViewModel(category: "Alcoholic", view: AnyView(ItemListView(dataProvider: AlcoholicDrinksViewModel())))
    ]
}
