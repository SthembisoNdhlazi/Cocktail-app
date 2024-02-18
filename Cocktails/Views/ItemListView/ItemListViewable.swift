//
//  ItemListView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/11/15.
//

import Foundation

protocol ItemListViewable: ObservableObject {
    var networking: CocktailsNetworking? { get set }
    var items: [Drink] {get set}
    var isLoading: Bool {get set}
    func setUpData()
}

struct ItemListViewModel {
    var imageURLString: String
    var title: String
    var subtitle: String
    var id: UUID = UUID()
    var isFavourite: Bool? 
    
    static func == (lhs: ItemListViewModel, rhs: ItemListViewModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(imageURLString: String, title: String, subtitle: String, isFavorite: Bool? = nil) {
        self.imageURLString = imageURLString
        self.title = title
        self.subtitle = subtitle
        self.isFavourite = isFavorite
    }
}
