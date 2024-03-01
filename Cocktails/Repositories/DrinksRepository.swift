//
//  AlcoholicDrinksRepository.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2024/02/29.
//

import Foundation
import ReusableComponents
import InjectPropertyWrapper

class DrinksRepository {
    @Inject var realm: any Persistable
    @Inject var networking: CocktailsNetworking
    
    func fetchDrinks(drinktype: DrinkTypes, selectedDrinkID: String? = nil, completion: @escaping ([Item]) -> Void) {
        var items: [Item] = []
        
        switch drinktype {
        case .alcoholic:
            networking.fetchJSON(drinkType: drinktype) { (result: Result<AlcoholicDrinks, NetworkError>) in
                switch result {
                case .success(let drinks):
                    DispatchQueue.main.async {
                        items = drinks.drinks.map({ drink in
                            
                            if let itemInRealm = self.realm.favouriteDrinks.first(where: {$0.drinkName.lowercased() == drink.strDrink.lowercased()}) {
                                Item(id: itemInRealm.id,
                                     drinkName: itemInRealm.drinkName,
                                     glass: itemInRealm.glass,
                                     instructions: itemInRealm.instructions,
                                     image: itemInRealm.image,
                                     category: itemInRealm.category,
                                     isFavorite: true)
                            } else {
                                Item(id: drink.idDrink, drinkName: drink.strDrink, glass: "", instructions: "", image: drink.strDrinkThumb, category: "Alcoholic", isFavorite: false)
                            }
                        })
                        completion(items)
                    }
                case .failure(let failure):
                    print("Error fetching drinks: \(failure)")
                }
            }
        case .nonAlcoholic:
            networking.fetchJSON(drinkType: drinktype) { (result: Result<NonAlcoholicDrink, NetworkError>) in
                switch result {
                case .success(let drinks):
                    DispatchQueue.main.async {
                        items = drinks.drinks.map({ drink in
                            
                            if let itemInRealm = self.realm.favouriteDrinks.first(where: {$0.drinkName.lowercased() == drink.strDrink.lowercased()}) {
                                Item(id: itemInRealm.id,
                                     drinkName: itemInRealm.drinkName,
                                     glass: itemInRealm.glass,
                                     instructions: itemInRealm.instructions,
                                     image: itemInRealm.image,
                                     category: itemInRealm.category,
                                     isFavorite: true)
                            } else {
                                Item(id: drink.idDrink, drinkName: drink.strDrink, glass: "", instructions: "", image: drink.strDrinkThumb, category: "Alcoholic", isFavorite: false)
                            }
                        })
                        completion(items)
                    }
                case .failure(let failure):
                    print("Error fetching drinks: \(failure)")
                }
            }
        case .detailedDrink:
            if let selectedDrinkID {
                networking.fetchJSON(drinkType: .detailedDrink, specificDrinkID: selectedDrinkID) { (result: Result<SearchedDrinkDetails, NetworkError>) in
                    switch result {
                    case .success(let searchedDrink):
                        if let searchedDrink = searchedDrink.drinks.first {
                            items.append(Item(id: searchedDrink.idDrink,
                                              drinkName: searchedDrink.strDrink,
                                              glass: searchedDrink.strGlass,
                                              instructions: searchedDrink.strInstructions,
                                              image: searchedDrink.strDrinkThumb,
                                              category: searchedDrink.strCategory,
                                              isFavorite: false))
                            completion(items)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("Missing drink ID")
            }
        }
    }
}
