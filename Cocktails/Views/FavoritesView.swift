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
    @StateObject var favoriteDrinksVM = FavoriteDrinksViewModel()
    
    @State var realm = RealmManager.sharedInstance
//    @StateObject var selectedDrinkViewModel = SelectedDrinkViewModel()
//    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    
    var body: some View {
        ItemListView(dataProvider: favoriteDrinksVM)
            .onAppear {
                favoriteDrinksVM.items = realm.favouriteDrinks.map({Item(id: $0.id,
                                                                          drinkName: $0.drinkName,
                                                                          glass: $0.glass,
                                                                          instructions: $0.instructions,
                                                                          image: $0.image,
                                                                          category: $0.category,
                                                                          isFavorite: $0.isFavourite)})
                favoriteDrinksVM.isLoading = false
            }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
