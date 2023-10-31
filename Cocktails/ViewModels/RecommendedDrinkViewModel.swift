//
//  RecommendedDrinkViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import Foundation
import SwiftUI

class RecommendedDrinkViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
    @Published var recommendedDrink: Drink = Drink(drinkName: "", glass: "", instructions: "", image: "", category: "")
    @Published var recommendedDrinks: [Drink] = []
    
    init() {
        getRecommendedDrink()
    }
    
    func getRecommendedDrink () {
        networking.getRandomDrink { drinks in
            let drink = drinks.drinks.first
            self.recommendedDrink = Drink(drinkName: drink?.strDrink ?? "", glass: drink?.strGlass ?? "", instructions: drink?.strIngredient1 ?? "", image: drink?.strDrinkThumb ?? "", category: drink?.strCategory ?? "")
            
            for drink in drinks.drinks {
                self.recommendedDrinks.append(Drink(drinkName: drink.strDrink , glass: drink.strGlass , instructions: drink.strIngredient1 , image: drink.strDrinkThumb , category: drink.strCategory))
            }
        }
    }
}
