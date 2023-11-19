//
//  SingleDrinkView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import SwiftUI

//Make the name more generic
struct SingleDrinkView: View {
    @ObservedObject var selectedDrinkViewModel: SelectedDrinkViewModel
    
    var body: some View {
        if let selectedDrink = selectedDrinkViewModel.detailedDrink {
            ScrollView {
                Text(selectedDrink.drinkName)
                    .font(.system(.title, design: .default, weight: .bold))
                    .padding()
                VStack {
                    if let imageURL = URL(string: selectedDrink.image) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 250, height: 250)
                                .cornerRadius(15)
                                .padding(.top)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 250, height: 250)
                        }
                    }
                }
                .padding()
                VStack {
                    Spacer()
                    HStack {
                        Text("Drink name")
                            .font(.system(.title2, design: .default, weight: .bold))
                            .padding()
                        Spacer()
                        Text(selectedDrink.drinkName)
                            .padding()
                    }
                    if let glass = selectedDrink.glass {
                        HStack {
                            Text("Glass type")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(glass)
                                .padding()
                        }
                    }
                    
                    if let category = selectedDrink.category {
                        HStack {
                            Text("Drink category")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(category)
                                .padding()
                        }
                    }
                    
                    if let instructions = selectedDrink.instructions {
                        VStack {
                            Text("Instructions")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(instructions)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                    }
                }
                
            }
        } else {
            VStack {
                ProgressView()
                Text("Hang tight...")
                Text("We're getting you some ingredients...")
            }
        }
    }
}

struct SingleDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedDrinkViewModel = SelectedDrinkViewModel()
        SingleDrinkView(selectedDrinkViewModel: selectedDrinkViewModel)
    }
}
