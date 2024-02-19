import SwiftUI
import Kingfisher

protocol DetailView {
    var selectedItem: Item { get }
}

struct ItemListView<Provider: ItemListViewable, DetailView: View>: View {
    @StateObject var dataProvider: Provider
    let detailView: (Item) -> DetailView
    
    init(dataProvider: Provider,  @ViewBuilder detailView: @escaping (Item) -> DetailView) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
        self.detailView = detailView
    }
    
    var body: some View {
        if !dataProvider.items.isEmpty && !dataProvider.isLoading {
            NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(($dataProvider.items), id: \.id) { item in
                            NavigationLink {
                                detailView(item.wrappedValue)
                            } label: {
                                HStack {
                                    if let imageURL = URL(string: item.image.wrappedValue) {
                                        KFImage(imageURL)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(15)
                                            .padding([.top, .horizontal])
                                            .shadow(color: .gray, radius: 5, x: 5, y: 5)
                                    } else {
                                        ProgressView()
                                            .frame(width: 250, height: 250)
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

