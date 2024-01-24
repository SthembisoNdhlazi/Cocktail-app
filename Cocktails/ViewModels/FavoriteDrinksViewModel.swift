//
//  FavoriteDrinksViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/21.
//

import Foundation
import RealmSwift

class FavoriteDrinksViewModel: ItemListViewable {
    var isLoading: Bool = true
    
    @Published var items: [Drink] = []
    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    
    init() {
        setUpData()
    }
    
    func setUpData() {
//        for drink in favoriteDrinks {
        items = favoriteDrinks.map({
            Drink(id: $0.id.description,
                  drinkName: $0.drinkName,
                  glass: $0.glass,
                  instructions: $0.instructions,
                  image: $0.image,
                  category: $0.category,
                  isFavorite: $0.isFavourite)
        })
        isLoading = false
//        }
    }
}
