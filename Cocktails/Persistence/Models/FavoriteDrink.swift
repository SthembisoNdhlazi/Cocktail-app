//
//  FavoriteDrink.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/21.
//

import Foundation
import RealmSwift

class FavoriteDrink: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    
    @Persisted var drinkName: String
    
    @Persisted var glass: String?
    
    @Persisted var instructions: String?
    
    @Persisted var image: String
    
    @Persisted var category: String?
    
    @Persisted var isFavourite: Bool = true
    
    convenience init(id: String, drinkName: String, glass: String? = nil, instructions: String? = nil, image: String, category: String? = nil, isFavourite: Bool) {
        self.init()
        self.id = id
        self.drinkName = drinkName
        self.glass = glass
        self.instructions = instructions
        self.image = image
        self.category = category
        self.isFavourite = isFavourite
    }
}
