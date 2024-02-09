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


//  RealmManager.swift
//  RealmManager
//
//  Created by Jonathan Bailey on 12/15/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//
import Foundation
import RealmSwift

public class RealmManager {
    private let database: Realm
    
    /// The shared instance of the realm manager.
    static let sharedInstance = RealmManager()
    
    /// Private initializer for the realm manager. Crashes if it cannot open the database.
    private init() {
        do {
            database = try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Retrieves the given object type from the database.
    ///
    /// - Parameter object: The type of object to retrieve.
    /// - Returns: The results in the database for the given object type.
    public func fetch<T: Object>(object: T) -> Results<T> {
        return database.objects(T.self)
    }
    
    /// Writes the given object to the database.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func save<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.add(object)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Overwrites the given object in the database if it exists. If not, it will write it as a new object.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
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
    
    /// Deletes the given object from the database if it exists.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    /// This works but you have to change views...
     func delete(object: FavoriteDrink, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                if let foundObjectIndex = database.objects(FavoriteDrink.self).firstIndex(where: {$0.drinkName == object.drinkName}) {
                    database.delete(database.objects(FavoriteDrink.self)[foundObjectIndex])
                }
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Deletes all existing data from the database. This includes all objects of all types.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
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
    
    /// Write method (supports save, update + delete) to be used in asynchronous situations. Write logic is passed in via the "action" closure parameter.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
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
