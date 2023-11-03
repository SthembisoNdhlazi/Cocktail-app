import SwiftUI

struct GridView: View {
    var drinks: [Drink] = [
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg",category: "Alcoholic"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg"),
    Drink(drinkName: "Something", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg")
    ]
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(drinks, id: \.id) { drink in
                    HStack {
                        if let imageURL = URL(string: drink.image) {
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
                            Text(drink.drinkName)
                                .font(.system(size: 16))
                            Text(drink.category ?? "")
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
        GridView()
    }
}
