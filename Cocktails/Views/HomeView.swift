//
//  HomeView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/31.
//

import SwiftUI

struct HomeView: View {
    let recommendedDrinkViewModel = RecommendedDrinkViewModel()
    let alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
    let nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel()
    
    @State var index = 0
    
    var body: some View {
        
        HStack(spacing: 0){
            
            VStack {
                Spacer()
                Group{
                    
                    
                    Button(action: {
                        
                        self.index = 3
                        
                    }) {
                        
                        VStack{
                            
                            Text("Alcoholic")
                                .frame(width: 120,height: 35)
                                .foregroundColor(self.index == 3 ? Color.black : Color.gray)
                                .underline(self.index == 3)
                            
                        }
                        //                        .background(Color.gray.opacity(self.index == 3 ? 1 : 0))
                        //                        .clipShape(CShape1())
                        
                    }
                    .rotationEffect(.init(degrees: -90))
                    .padding(.top, 80)
                    
                    Spacer(minLength: 0)
                    
                    // adding remaining tabs....
                    
                    Button(action: {
                        
                        self.index = 2
                        
                    }) {
                        
                        VStack{
                            
                            Text("Non Alcoholic")
                            // Fixed width because we re going to rotate views....
                            
                                .frame(width: 120,height: 35)
                                .underline(self.index == 2)
                            //changing textcolor based on index...
                                .foregroundColor(self.index == 2 ? Color.black : Color.gray)
                            
                        }
                        //changing bg color based on index...
                        //                        .background(Color.gray.opacity(self.index == 3 ? 1 : 0))
                        //                        .clipShape(CShape1())
                        
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 1
                        
                    }) {
                        
                        VStack{
                            
                            Text("My favorites")
                            // Fixed width because we re going to rotate views....
                            
                                .frame(width: 120,height: 35)
                                .underline(self.index == 1)
                            //changing textcolor based on index...
                                .foregroundColor(self.index == 1 ? Color.black : Color.gray)
                            
                        }
                        //changing bg color based on index...
                        //                        .background(Color.gray.opacity(self.index == 3 ? 1 : 0))
                        //                        .clipShape(CShape1())
                        
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 0
                        
                    }) {
                        
                        VStack{
                            
                            Text("Search")
                            // Fixed width because we re going to rotate views....
                            
                                .frame(width: 120,height: 35)
                            
                            //changing textcolor based on index...
                                .foregroundColor(self.index == 0 ? Color.black : Color.gray)
                                .underline(self.index == 0)
                        }
                        //                        .clipShape(CShape1())
                        
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
                    
                }
                Spacer()
                
            }
            .padding(.vertical)
            // Fixed Width....
            .frame(width: 85)
            .background(Color.clear)
            //            .clipShape(CShape())
            
            
            // now were going to create main view....
            
            GeometryReader{ reader in
                
                VStack {
//                    HStack {
//                        Spacer(minLength: reader.size.width/3.5)
//                        Text ("Loosen up")
//                            .foregroundColor(.black)
//                            .font(.system(size: 30))
//                    }
//
//                    HStack {
//                        Spacer(minLength: reader.size.width/3.5)
//                        Text ("Have a cocktail...")
//                            .foregroundColor(.black)
//                            .font(.system(size: 15))
//                    }
                    if self.index == 0{
                        //search goes here
                        VStack {
                            Spacer()
                            Text("Search goes here")
                            Spacer()
                        }
//                        LandingView(recommendedDrinkViewModel: recommendedDrinkViewModel,
//                                    alcoholicDrinksViewModel: alcoholicDrinksViewModel, nonAlcoholicDrinksViewModel: nonAlcoholicDrinksViewModel)
                    }
                    else if self.index == 1{
                        VStack {
                            Spacer()
                            Text("My favourites go here")
                            Spacer()
                        }
                    }
                    else if self.index == 2{
                            VStack {
                                ForEach(nonAlcoholicDrinksViewModel.nonAlcoholicDrinks, id: \.self) { nonAlcoholicDrink in
                                    SingleDrinkView(drink: nonAlcoholicDrink)
                                }
                            }
                            .padding()
                    }
                    else{
                        VStack {
                            ForEach(alcoholicDrinksViewModel.allAlcoholicDrinks, id: \.self) { nonAlcoholicDrink in
                                SingleDrinkView(drink: nonAlcoholicDrink)
                            }
                        }
                        .padding()
                    }
                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
                // due to all edges are ignored...
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
