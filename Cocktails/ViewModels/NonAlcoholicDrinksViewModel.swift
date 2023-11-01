//
//  NonAlcoholicDrinksViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/31.
//

import Foundation
import SwiftUI

class NonAlcoholicDrinksViewModel: ObservableObject {
    var networking = CocktailsServiceCalls()
    @Published var nonAlcoholicDrinks: [Drink] = []
    
    init() {
        getAlcoholicDrinks()
    }
    
    private func getAlcoholicDrinks() {
        networking.getNonAlcoholicDrinks { drinks in
            for drink in drinks.drinks {
                self.nonAlcoholicDrinks.append(Drink(drinkName: drink.strDrink, image: drink.strDrinkThumb))
            }
        }
    }
}
