//
//  FavoritesView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/21.
//

import SwiftUI
import RealmSwift

//MARK: Gotta fix this homie, we should use ItemListView directly
//MARK: We did this because the data didn't reload when you saved to realm
struct FavoritesView: View {
    @StateObject var favoriteDrinksVM = FavoriteDrinks()
    
    @State var realm = RealmManager.sharedInstance
//    @StateObject var selectedDrinkViewModel = SelectedDrinkViewModel()
    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    
    var body: some View {
        ItemListView(dataProvider: favoriteDrinksVM)
            .onAppear {
                favoriteDrinksVM.items = favoriteDrinks.map({ favDrink in
                    Drink(id: favDrink.id.description,
                          drinkName: favDrink.drinkName,
                          glass: favDrink.glass,
                          instructions: favDrink.instructions,
                          image: favDrink.image,
                          category: favDrink.category,
                          isFavorite: favDrink.isFavourite)
                })
                favoriteDrinksVM.isLoading = false
            }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

class FavoriteDrinks: ItemListViewable {
    var isLoading: Bool = true
    
    var items: [Drink] = []
    
    func setUpData() {
        
    }
}
