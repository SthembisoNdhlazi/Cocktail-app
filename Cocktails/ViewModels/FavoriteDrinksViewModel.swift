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
    
    @Published var items: [ItemListViewModel] = []
    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    
    init() {
        setUpData()
    }
    
    func setUpData() {
//        for drink in favoriteDrinks {
        items = favoriteDrinks.map({ItemListViewModel(imageURLString: $0.image,
                                                      title: $0.drinkName,
                                                      subtitle: $0.category ?? "") })
        isLoading = false
//        }
    }
}
