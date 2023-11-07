//
//  CocktailsApp.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import SwiftUI
import SideBarComponent

@main
struct CocktailsApp: App {
    var body: some Scene {
        WindowGroup {
//            let recommendedDrinkViewModel = RecommendedDrinkViewModel()
//            let alcoholicDrinksViewModel = AlcoholicDrinksViewModel()
//            let nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel()
//
            SidebarComponent(dataProvider: SideBarDataProvider(), title: "Cocktails")
        }
    }
}
