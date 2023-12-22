//
//  FavoriteDrink.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/21.
//

import Foundation
import RealmSwift

class FavoriteDrink: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var drinkName: String
    
    @Persisted var glass: String?
    
    @Persisted var instructions: String?
    
    @Persisted var image: String
    
    @Persisted var category: String?
    
    @Persisted var isFavourite: Bool = true
}
