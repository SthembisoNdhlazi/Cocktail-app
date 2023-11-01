import SwiftUI

protocol SideBarConfigurable: ObservableObject {
    var categories: [SideBarViewModel] { get set }
}

struct SidebarComponent<Provider: SideBarConfigurable>: View {
    @StateObject var dataProvider: Provider
    @State var selectedView: AnyView = AnyView(EmptyView())
    @State var index = 3
    let recommendedDrinkViewModel = RecommendedDrinkViewModel()
    let alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
    let nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel()
    
    init(dataProvider: Provider) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
        index = 3
        selectedView = dataProvider.categories.first?.view ?? AnyView(EmptyView())
    }
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            VStack {
                Spacer()
                Group {
                    
                    ForEach(Array((dataProvider.categories.enumerated())), id: \.offset) { index, category in
                        Button(action: {
                            self.index = index
                            self.selectedView = category.view
                        }) {
                            VStack {
                                Text(category.category)
                                    .frame(width: 120,height: 35)
                                    .foregroundColor(self.index == index ? Color.black : Color.gray)
                                    .underline(self.index == index)
                            }
                        }
                        .rotationEffect(.init(degrees: -90))
                        .padding(.top, 80)
                    }
                }
                Spacer()
            }
            .padding(.vertical)
            .frame(width: 85)
            .background(Color.clear)
            .onAppear {
                if let firstView = dataProvider.categories.first?.view {
                    selectedView = firstView
                } else {
                    selectedView = AnyView(EmptyView())
                }
            }
            
            GeometryReader { reader in
                
                VStack {
                    Spacer()
                    selectedView
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = SideBarDataProvider()
        SidebarComponent(dataProvider: dataProvider)
    }
}
