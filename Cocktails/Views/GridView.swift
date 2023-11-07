import SwiftUI

protocol ItemListView: ObservableObject {
    var items: [ItemListViewModel] {get set}
}

struct ItemListViewModel {
    var imageURLString: String
    var title: String
    var subtitle: String
    var id: UUID = UUID()
    
    static func == (lhs: ItemListViewModel, rhs: ItemListViewModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(imageURLString: String, title: String, subtitle: String) {
        self.imageURLString = imageURLString
        self.title = title
        self.subtitle = subtitle
    }
}

class AlcoholicDrinksDataProvider: ItemListView {
    @ObservedObject var alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
    var items: [ItemListViewModel] = []
    
    init() {
        setUpAlcoholicDrinks()
    }
    
    func setUpAlcoholicDrinks() {
        for drink in alcoholicDrinksViewModel.allAlcoholicDrinks {
            items.append(ItemListViewModel(imageURLString: drink.image, title: drink.drinkName, subtitle: drink.category ?? ""))
        }
    }
}

struct GridView<Provider: ItemListView>: View {
    @StateObject var dataProvider: Provider
    
    init(dataProvider: Provider) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(Array((dataProvider.items.enumerated())), id: \.offset) { index, item in
                    HStack {
                        if let imageURL = URL(string: item.imageURLString) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(15)
                                    .padding([.top, .horizontal])
                                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        Spacer()
                        VStack(alignment: .center, spacing: 5) {
                            Text(item.title)
                                .font(.system(size: 16))
                            Text(item.subtitle)
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            
            //            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = AlcoholicDrinksDataProvider()
        GridView(dataProvider: dataProvider)
    }
}
