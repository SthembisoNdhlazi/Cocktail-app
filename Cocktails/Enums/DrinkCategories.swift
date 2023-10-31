import Foundation

enum DrinkCategories: String {
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non-Alcoholic"
    case favourites = "Favourites"
    case search = "Search"
}

protocol Drinkable: Hashable {
    var drinkName:String { get }
    var glass: String? { get }
    var instructions: String? { get }
    var image: String { get }
    var category:String? { get }
}
