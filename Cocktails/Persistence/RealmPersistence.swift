//
//  RealmPersistence.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2024/01/02.
//

import Foundation
import RealmSwift

class RealmPersistence: ObservableObject {
//    let shared = RealmPersistence()
    var realm: Realm?
    @Published var showSuccessToast: Bool = false
    @Published var showRemoveToast: Bool = false
    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    
    init() {
      setUpRealm()
    }
    
    func setUpRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 0)
            Realm.Configuration.defaultConfiguration = config
            realm = try Realm()
        } catch {
            print("Error setting up realm: \(error)")
        }
    }
    
    func save(drink: FavoriteDrink) {
        try? realm?.write {
            realm?.add(drink)
            print("Item was saved")
            showSuccessToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.showSuccessToast = false
            }
        }
    }
    
    func delete(drink: FavoriteDrink) {
        do {
//            let realmObject = try Realm()
            
            try realm?.write {
                if let foundItemIndex = favoriteDrinks.firstIndex(where: {$0.drinkName.lowercased() == drink.drinkName.lowercased()}) {
                    realm?.delete(favoriteDrinks[foundItemIndex])
                    
                     showRemoveToast = true
                     DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                         self.showRemoveToast = false
                     }
                     print("Drink deleted")
                }
            }
        } catch {
            print("Couldn't delete item \(drink)")
        }
    }
}
