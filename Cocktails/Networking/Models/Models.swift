import Foundation

typealias drinkableCocktail = Codable & Sequence

// MARK: - Alcoholic drink
struct AlcoholicDrinks: Codable {
    let drinks: [AlcoholicDrinkItems]
}

struct AlcoholicDrinkItems: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

 // MARK: - Random drink
struct RandomDrink: Codable {
    let drinks: [RandomDrinkDetails]
}

// MARK: - Random drink details
struct RandomDrinkDetails: Codable {
    let idDrink: String
    let strDrink: String
    let strCategory: String
    let strAlcoholic, strGlass, strInstructions: String
    let strDrinkThumb: String
    let strIngredient1, strIngredient2: String
    let strIngredient3, strIngredient4: String?

    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strCategory, strAlcoholic, strGlass, strInstructions

        case strDrinkThumb, strIngredient1, strIngredient2, strIngredient3, strIngredient4
    }
}

// MARK: - Non-Alcoholic drinks
struct NonAlcoholicDrink: Codable {
    let drinks: [NonAlcoholicDrinkItems]
}

// MARK: - Drink
struct NonAlcoholicDrinkItems: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

// MARK: - SelectedDrinkDetails
struct SelectedDrinkDetails: Codable {
    let drinks: [SelectedDrink]
}

// MARK: - Selected drink
struct SelectedDrink: Codable {
    let idDrink: String
    let strDrink: String

    let strCategory, strAlcoholic, strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
    let strIngredient1, strIngredient2: String
    let strIngredient3, strIngredient4: String?


    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strCategory, strAlcoholic, strGlass, strInstructions
        case strDrinkThumb, strIngredient1, strIngredient2, strIngredient3, strIngredient4
    }
}

// MARK: - SearchedDrinkDetails
struct SearchedDrinkDetails: Codable {
    let drinks: [SearchedDrink]
}

// MARK: - Searched Drink
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
