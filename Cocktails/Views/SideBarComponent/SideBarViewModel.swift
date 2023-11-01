import Foundation
import SwiftUI

struct SideBarViewModel: Hashable {
    static func == (lhs: SideBarViewModel, rhs: SideBarViewModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    var view: AnyView
    var category: String
    init(category: String, view: AnyView) {
        self.category = category
        self.view = view
    }
}
