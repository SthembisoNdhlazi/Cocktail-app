import SwiftUI

struct ItemListView<Provider: ItemListViewable>: View {
    @StateObject var dataProvider: Provider
    
    init(dataProvider: Provider) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
    }
    
    var body: some View {
        if !dataProvider.items.isEmpty && !dataProvider.isLoading {
            NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(($dataProvider.items), id: \.id) { item in
                            NavigationLink {
                                //MARK: make this selectedItemView and move them together
                                SingleDrinkView(selectedDrink: item.wrappedValue)
                            } label: {
                                HStack {
                                    if let imageURL = URL(string: item.image.wrappedValue) {
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
                                        Text(item.drinkName.wrappedValue)
                                            .font(.system(size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                        Text(item.category.wrappedValue ?? "-")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 13))
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .scrollIndicators(.hidden)
                .padding(.trailing)
            }
        } else if dataProvider.isLoading {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        } else {
           EmptyStateView(systemImage: "wineglass", emptyStateText: "Looks like you dont have any items...")
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let networking = CocktailsServiceCalls()
        let dataProvider = AlcoholicDrinksViewModel(networking: networking)
        ItemListView(dataProvider: dataProvider)
    }
}
