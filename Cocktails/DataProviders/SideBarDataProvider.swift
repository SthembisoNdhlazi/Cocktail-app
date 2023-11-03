import Foundation
import SwiftUI

class SideBarDataProvider: SideBarConfigurable {
    @Published var categories: [SideBarViewModel] = [
        SideBarViewModel(category: "Search", view: AnyView(Text("Search view"))),
        SideBarViewModel(category: "Non alcoholic", view: AnyView(Text("Non alcoholic"))),
        SideBarViewModel(category: "My favorites", view: AnyView(GridView())),
        SideBarViewModel(category: "Alcoholic", view: AnyView(GridView()))]
}
