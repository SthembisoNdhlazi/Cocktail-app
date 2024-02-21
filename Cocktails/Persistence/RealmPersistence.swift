//
//  RealmPersistence.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2024/01/02.
//

import Foundation
import RealmSwift

//class RealmPersistence: ObservableObject {
////    let shared = RealmPersistence()
//    var realm: Realm?
//    @Published var showSuccessToast: Bool = false
//    @Published var showRemoveToast: Bool = false
//    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
//
//    init() {
//      setUpRealm()
//    }
//
//    func setUpRealm() {
//        do {
//            let config = Realm.Configuration(schemaVersion: 0)
//            Realm.Configuration.defaultConfiguration = config
//            realm = try Realm()
//        } catch {
//            print("Error setting up realm: \(error)")
//        }
//    }
//
//    func save(drink: FavoriteDrink) {
//        try? realm?.write {
//            realm?.add(drink)
//            print("Item was saved")
//            showSuccessToast = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                self.showSuccessToast = false
//            }
//        }
//    }
//
//    func delete(drink: FavoriteDrink) {
//        do {
////            let realmObject = try Realm()
//
//            try realm?.write {
//                if let foundItemIndex = favoriteDrinks.firstIndex(where: {$0.drinkName.lowercased() == drink.drinkName.lowercased()}) {
//                    realm?.delete(favoriteDrinks[foundItemIndex])
//
//                     showRemoveToast = true
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                         self.showRemoveToast = false
//                     }
//                     print("Drink deleted")
//                }
//            }
//        } catch {
//            print("Couldn't delete item \(drink)")
//        }
//    }
//}


import Foundation
import RealmSwift

protocol Persistable {
    var database: Realm { get }
    var favouriteDrinks: [FavoriteDrink] {get set}
    func save<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void))
    func delete(object: FavoriteDrink, errorHandler: @escaping ((_ error : Swift.Error) -> Void))
}

public class RealmManager: Persistable {
    internal let database: Realm
    
    @Published var favouriteDrinks: [FavoriteDrink] = []

     init() {
        do {
            database = try Realm()
            favouriteDrinks = Array(fetch(object: FavoriteDrink()))
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func fetch<T: Object>(object: T) -> Results<T> {
        return database.objects(T.self)
    }
    
    public func save<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.add(object)
                favouriteDrinks = Array(fetch(object: FavoriteDrink()))
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    public func update<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
//                database.add(object, update: true)
                database.add(object, update: .all)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
     func delete(object: FavoriteDrink, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                if let foundObjectIndex = database.objects(FavoriteDrink.self).firstIndex(where: {$0.drinkName == object.drinkName}) {
                    database.delete(database.objects(FavoriteDrink.self)[foundObjectIndex])
                    favouriteDrinks = Array(fetch(object: FavoriteDrink()))
                }
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    public func deleteAll(errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.deleteAll()
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    public func asyncWrite<T: ThreadConfined>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }, action: @escaping ((Realm, T?) -> Void)) {
        let threadSafeRef = ThreadSafeReference(to: object)
        let config = self.database.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    let obj = realm.resolve(threadSafeRef)
                    
                    try realm.write {
                        action(realm, obj)
                    }
                }
                catch {
                    errorHandler(error)
                }
            }
        }
    }
}
