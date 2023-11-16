import Foundation
import SwiftUI
import SideBarComponent

class SideBarDataProvider: SideBarConfigurable {
    @Published var categories: [SideBarViewModel] = [
        SideBarViewModel(category: "Search", view: AnyView(ItemListView(dataProvider: AlcoholicDrinksViewModel()))),
        SideBarViewModel(category: "Non alcoholic", view: AnyView(Text("Non alcoholic"))),
        SideBarViewModel(category: "My favorites", view: AnyView(ItemListView(dataProvider: AlcoholicDrinksViewModel()))),
        SideBarViewModel(category: "Alcoholic", view: AnyView(Text("Alcoholic")))
    ]
}
