////
////  ContentView.swift
////  Cocktails
////
////  Created by Sthembiso Ndhlazi on 2023/10/08.
////
//
//import SwiftUI
//
//struct LandingView: View {
//    @StateObject var recommendedDrinkViewModel: RecommendedDrinkViewModel
//    @StateObject var alcoholicDrinksViewModel: AlcoholicDrinksViewModel
//    @StateObject var nonAlcoholicDrinksViewModel: NonAlcoholicDrinksViewModel
//    var categories: [DrinkCategories] = [.alcoholic, .nonAlcoholic]
//    
//    var body: some View {
//        ScrollView {
//            
//            Text("Try something new")
//            SingleDrinkView(drink: recommendedDrinkViewModel.recommendedDrink)
//                .padding(.top)
//            Spacer()
//            ForEach(categories, id: \.self) { category in
//                switch category {
//                case .alcoholic:
//                    Text("Alcoholic drinks")
//                        .padding(.top)
//                    ScrollView (.horizontal) {
//                        HStack {
//                            ForEach(alcoholicDrinksViewModel.items, id: \.self) { alcoholicDrink in
//                                SingleDrinkView(drink: alcoholicDrink)
//                            }
//                        }
//                        .padding()
//                    }
//                    .scrollIndicators(.hidden)
//                case .nonAlcoholic:
//                    // loop through all the non-alcoholic drinks and display them
//                    Text("Non alcoholic drinks")
//                        .padding(.top)
//                    ScrollView (.horizontal) {
//                        HStack {
//                            ForEach(nonAlcoholicDrinksViewModel.nonAlcoholicDrinks, id: \.self) { nonAlcoholicDrink in
//                                SingleDrinkView(drink: nonAlcoholicDrink)
//                            }
//                        }
//                        .padding()
//                    }
//                    .scrollIndicators(.hidden)
//                default:
//                    Text("Also coming soon")
//                }
//            }
//        }
//        
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let recommendedDrinkViewModel = RecommendedDrinkViewModel()
//        let alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
//        let nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel()
//        
//        LandingView(recommendedDrinkViewModel: recommendedDrinkViewModel, alcoholicDrinksViewModel: alcoholicDrinksViewModel, nonAlcoholicDrinksViewModel: nonAlcoholicDrinksViewModel)
//    }
//}
