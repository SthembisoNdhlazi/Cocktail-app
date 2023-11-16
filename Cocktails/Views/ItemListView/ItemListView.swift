import SwiftUI

struct ItemListView<Provider: ItemListViewable>: View {
    @StateObject var dataProvider: Provider
    
    init(dataProvider: Provider) {
        self._dataProvider = StateObject(wrappedValue: dataProvider)
    }
    
    var body: some View {
        if !dataProvider.items.isEmpty {
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
                                //save this to realm and toggle is favourite
                            } label: {
                                Image(systemName: item.isFavourite ? "heart.fill" : "heart")
                                    .foregroundColor(.black)
                            }
//                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
        } else {
            ProgressView()
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = AlcoholicDrinksViewModel()
        ItemListView(dataProvider: dataProvider)
    }
}
