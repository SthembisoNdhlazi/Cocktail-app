import SwiftUI
import SideBarComponent
struct LandingView: View {
    
    @State var navPath = NavigationPath()    
    let view: AnyView
    init(view: AnyView) {
        self.view = view
    }
    
    var body: some View {
        NavigationStack(path: $navPath) {
//            SidebarComponent(dataProvider: SideBarDataProvider(networking: networking), title: "Cocktails")
            view
        }
        .accentColor(.black)
    }
}
