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
                        ForEach(($dataProvider.items), id: \.id) { item in
                            NavigationLink {
                                //fix this
                                SingleDrinkView(selectedDrinkViewModel: selectedDrinkViewModel)
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
                            //get rid of this
                            .simultaneousGesture(TapGesture().onEnded({ _ in
                                if let _ = item.isFavorite.wrappedValue {
                                    selectedDrinkViewModel.selectedDrink = item.wrappedValue
                                   
                                } else {
                                    selectedDrinkViewModel.setUpDrink(with: item.wrappedValue)
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
