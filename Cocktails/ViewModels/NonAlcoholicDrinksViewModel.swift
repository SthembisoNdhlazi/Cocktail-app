//
//  NonAlcoholicDrinksViewModel.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/31.
//

import Foundation
import SwiftUI
import ReusableComponents
import RealmSwift

class NonAlcoholicDrinksViewModel: ItemListViewable {
    var items: [Item] = []
    var isLoading: Bool = true
    var drinksRepository: DrinksRepository
    private var notificationToken: NotificationToken?
    
    init(drinksRepository: DrinksRepository) {
        self.drinksRepository = drinksRepository
        setUpData()
        observeRealmChanges()
    }
    
    func setUpData() {
        drinksRepository.fetchDrinks(drinktype: .nonAlcoholic) { drinks in
            self.items = drinks
            self.isLoading = false
        }
    }
    
    private func observeRealmChanges() {
        let realm = try! Realm()
        let favouriteDrinks = realm.objects(FavoriteDrink.self)
        notificationToken = favouriteDrinks.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                for drink in favouriteDrinks {
                    if let drinkIndexFromRealm = self.items.firstIndex(where: {$0.drinkName.lowercased() == drink.drinkName.lowercased()}) {
                        self.items[drinkIndexFromRealm] = Item(id: drink.id,
                                                               drinkName: drink.drinkName,
                                                               glass: drink.glass,
                                                               instructions: drink.instructions,
                                                               image: drink.image,
                                                               category: drink.category,
                                                               isFavorite: drink.isFavourite)
                    }
                }
            case .error:
                print("Error updating drinks")
                break
            }
        }
    }
}
