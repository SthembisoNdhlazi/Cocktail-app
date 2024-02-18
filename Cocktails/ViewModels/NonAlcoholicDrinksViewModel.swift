//
//  NonAlcoholicDrinksViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/31.
//

import Foundation
import SwiftUI

class NonAlcoholicDrinksViewModel: ItemListViewable {
    @Published var items: [Item] = []
    var isLoading: Bool = true
    
    var networking: CocktailsNetworking?
    
    init(networking: CocktailsNetworking) {
        self.networking = networking
        setUpData()
    }
    
    func setUpData() {
        networking?.fetchJSON(drinkType: .nonAlcoholic) { (result: Result<NonAlcoholicDrink, NetworkError>) in
            switch result {
            case .success(let alcoholicDrinks):
                self.items = alcoholicDrinks.drinks.map({ drink in
                    Item(id: drink.idDrink,
                          drinkName: drink.strDrink,
                          glass: nil,
                          instructions: nil,
                          image: drink.strDrinkThumb,
                          category: "Non Alcoholic",
                          isFavorite: false)
                })
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
        isLoading = false
    }
}
