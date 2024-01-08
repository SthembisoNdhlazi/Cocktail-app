import SwiftUI

struct ItemListView<Provider: ItemListViewable>: View {
    @StateObject var dataProvider: Provider
    @StateObject var selectedDrinkViewModel = SelectedDrinkViewModel()
    init(dataProvider: Provider) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
    }
    
    var body: some View {
        if !dataProvider.items.isEmpty && !dataProvider.isLoading {
            NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(Array((dataProvider.items.enumerated())), id: \.offset) { index, item in
                            NavigationLink {
                                SingleDrinkView(selectedDrinkViewModel: selectedDrinkViewModel)
                            } label: {
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
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                        Text(item.subtitle)
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 13))
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
//                                    Button {
//                                        if let foundItemIndex = dataProvider.items.firstIndex(where: {$0.id == item.id}) {
//                                            dataProvider.items[foundItemIndex].isFavourite.toggle()
//                                        }
//                                    } label: {
//                                        Image(systemName: item.isFavourite ? "heart.fill" : "heart")
//                                            .foregroundColor(.black)
//                                    }
                                    //                            Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .simultaneousGesture(TapGesture().onEnded({ _ in
                                if let isFavourite = item.isFavourite {
                                    selectedDrinkViewModel.detailedDrink = Drink(
                                        id: item.id.uuidString,
                                        drinkName: item.title,
                                        image: item.imageURLString,
                                        category: item.subtitle,
                                        isFavorite: isFavourite)
                                   
                                } else {
                                    selectedDrinkViewModel.setUpDrink(with: Drink(
                                        id: item.id.uuidString,
                                        drinkName: item.title,
                                        image: item.imageURLString,
                                        category: item.subtitle,
                                        isFavorite: item.isFavourite
                                    ))
                                }
                            }))
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
        let dataProvider = AlcoholicDrinksViewModel()
        ItemListView(dataProvider: dataProvider)
    }
}
