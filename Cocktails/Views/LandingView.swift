import SwiftUI
import SideBarComponent

struct LandingView: View {
    
    @State var navPath = NavigationPath()
    var categories: [DrinkCategories] = [.alcoholic, .nonAlcoholic]
    
    
    var body: some View {
        NavigationStack(path: $navPath) {
            SidebarComponent(dataProvider: SideBarDataProvider(), title: "Cocktails")
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let recommendedDrinkViewModel = RecommendedDrinkViewModel()
        let alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
        let nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel()
        
        LandingView()
    }
}
