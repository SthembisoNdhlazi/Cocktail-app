//
//  Drink.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import Foundation

struct Drink: Drinkable, Identifiable {
    var id: String = UUID().uuidString
    
    var drinkName: String
    
    var glass: String?
    
    var instructions: String?
    
    var image: String
    
    var category: String?
    
}
