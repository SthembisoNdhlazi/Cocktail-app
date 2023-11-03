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
    }
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            VStack {
//                Spacer()
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
//                Spacer()
            }
            .padding(.vertical)
            .frame(width: 85)
            .background(Color.clear)
            .onAppear {
                if let firstView = dataProvider.categories.first?.view {
                    index = 0
                    selectedView = firstView
                } else {
                    selectedView = AnyView(EmptyView())
                }
            }
            
            GeometryReader { reader in
                
                HStack {
                    Spacer(minLength: reader.size.width * 0.1)
                    Text("Cocktails")
                    Spacer(minLength: reader.size.width * 0.5)
                }
                .padding(.top, 60)
                
                VStack {
                    selectedView
                        .padding(.trailing, 5)
                }
                .padding(.top, 150)
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
