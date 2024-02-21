import Foundation

struct AlcoholicDrinks: Codable {
    let drinks: [AlcoholicDrinkItems]
}

struct AlcoholicDrinkItems: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

struct NonAlcoholicDrink: Codable {
    let drinks: [NonAlcoholicDrinkItems]
}

struct NonAlcoholicDrinkItems: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

struct SearchedDrinkDetails: Codable {
    let drinks: [SearchedDrink]
}

struct SearchedDrink: Codable {
    let idDrink: String
    let strDrink: String
    let strCategory: String
    let strAlcoholic, strGlass, strInstructions: String
    let strDrinkThumb: String
    let strIngredient1, strIngredient2:String

    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strCategory, strAlcoholic, strGlass, strInstructions
        case strDrinkThumb, strIngredient1, strIngredient2
    }
}
