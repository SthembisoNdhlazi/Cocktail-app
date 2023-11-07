import Foundation
import SwiftUI
import SideBarComponent

class SideBarDataProvider: SideBarConfigurable {
    @Published var categories: [SideBarViewModel] = [
        SideBarViewModel(category: "Search", view: AnyView(Text("Search view"))),
        SideBarViewModel(category: "Non alcoholic", view: AnyView(Text("Non alcoholic"))),
        SideBarViewModel(category: "My favorites", view: AnyView(GridView(dataProvider: AlcoholicDrinksDataProvider()))),
        SideBarViewModel(category: "Alcoholic", view: AnyView(Text("Alcoholic")))
    ]
}
