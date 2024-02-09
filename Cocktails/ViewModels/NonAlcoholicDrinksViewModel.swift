//
//  NonAlcoholicDrinksViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/31.
//

import Foundation
import SwiftUI

class NonAlcoholicDrinksViewModel: ItemListViewable {
    var isLoading: Bool = true
    
    var networking = CocktailsServiceCalls()
    @Published var items: [Drink] = []
    
    init() {
        setUpData()
    }
    
    func setUpData() {
        networking.getNonAlcoholicDrinks { drinks in
            for drink in drinks.drinks {
                self.items.append(Drink(id: drink.idDrink ,drinkName: drink.strDrink, image: drink.strDrinkThumb,category: "Non alcoholic"))
            }
        }
        isLoading = false
    }
}
