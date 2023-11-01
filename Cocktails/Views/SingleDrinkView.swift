//
//  SingleDrinkView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import SwiftUI

//Make the name more generic
struct SingleDrinkView: View {
    var drink: any Drinkable
    var body: some View {
        ZStack {
            VStack {
                if let imageURL = URL(string: drink.image) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 250, height: 250)
//                            .mask(LinearGradient(gradient: Gradient(stops: [
//                                .init(color: .black, location: 0),
//                                .init(color: .clear, location: 1),
//                                .init(color: .black, location: 1),
//                                .init(color: .clear, location: 1)
//                            ]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(15)
                            .padding(.top)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 250, height: 250)
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Text(drink.drinkName)
                        .padding()
                    Spacer()
                }
                if let glass = drink.glass {
                    HStack {
                        Text(glass)
                            .padding()
                        Spacer()
                    }
                }
                
                if let category = drink.category {
                    HStack {
                        Text(category)
                            .padding()
                        Spacer()
                    }
                }
            }
            
        }
        .frame(width: 350, height:450)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 5)
        }
    }
}

struct SingleDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        var selectedDrink: Drink = Drink(drinkName: "Mojito", glass: "Normal glass", instructions: "Just drink", image: "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito.jpg", category: "Extremely alcoholic")
        SingleDrinkView(drink: selectedDrink)
    }
}
