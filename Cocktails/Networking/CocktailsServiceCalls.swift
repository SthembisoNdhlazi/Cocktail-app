
import Foundation
import UIKit

class CocktailsServiceCalls {
    // MARK: all networking variables and URLs
    var alcoholicDrinkURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
    var randomDrinkURL = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
    let nonAlcoholicDrinksURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    let selectedDrinkURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    let searchDrinkURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    
    var drinks: AlcoholicDrinks?
    var randomDrink: RandomDrink?
    var nonAlcoholicDrinks: NonAlcoholicDrink?
    var drinkDetails: SelectedDrinkDetails?
    var searchedDrink: SearchedDrinkDetails?
// link for getting the ingredients by searching by name -> www.thecocktaildb.com/api/json/v1/1/search.php?i=vodka
    //MARK: Alcoholic drinks network call
    func getAlcoholicDrinks(completion: @escaping (AlcoholicDrinks) -> Void) {
        guard let url = URL(string: alcoholicDrinkURL) else {
            fatalError("Invalid URL")
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                    do {
                        self?.drinks = try JSONDecoder().decode(AlcoholicDrinks.self, from: data)
                        if let safeDrinks = self?.drinks {
                            completion(safeDrinks)
                            
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
            }
        }.resume()
    }

    //MARK: Random drink network call
    func getRandomDrink(completion: @escaping (RandomDrink) -> Void){
        guard let url = URL(string: randomDrinkURL) else {
            fatalError("Invalid URL")
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {

                    do {
                        self?.randomDrink = try JSONDecoder().decode(RandomDrink.self, from: data)

                        if let safeDrinks = self?.randomDrink {
                            completion(safeDrinks)

                        }

                    } catch {
                        print(error.localizedDescription)
                    }

            }
        }.resume()
    }
    //MARK: Non alcoholic drinks network call
    func getNonAlcoholicDrinks(completion: @escaping (NonAlcoholicDrink) -> Void) {

        guard let url = URL(string: nonAlcoholicDrinksURL) else {
            fatalError("Invalid URL")
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                    do {
                        self?.nonAlcoholicDrinks = try JSONDecoder().decode(NonAlcoholicDrink.self, from: data)

                        if let safeDrinks = self?.nonAlcoholicDrinks {
                            completion(safeDrinks)
                        }

                    } catch {
                        print(error.localizedDescription)
                    }
            }
        }.resume()
    }
    //MARK: Selected drink details network call
    func getSelectedDrinkDetails(drinkId:String, completion: @escaping (SelectedDrinkDetails) -> Void) {

        guard let url = URL(string: selectedDrinkURL + drinkId) else {
            fatalError("Invalid URL")
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                    do {
                        self?.drinkDetails = try JSONDecoder().decode(SelectedDrinkDetails.self, from: data)

                        if let safeDrinks = self?.drinkDetails {
                            completion(safeDrinks)
                        }

                    } catch {
                        print(error.localizedDescription)
                    }
            }
        }.resume()
    }

    //MARK: Search for cocktail network call
    func searchForDrink(drinkName:String, completion: @escaping (SearchedDrinkDetails) -> Void) {
        let trimmedDrinkName = drinkName.trimmingCharacters(in: .whitespaces)
        let searchDrinkName = trimmedDrinkName.replacingOccurrences(of: " ", with: "_")

        guard let url = URL(string: searchDrinkURL + searchDrinkName) else {
            fatalError("Invalid URL")
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                    do {
                        self?.searchedDrink = try JSONDecoder().decode(SearchedDrinkDetails.self, from: data)

                        if let safeDrinks = self?.searchedDrink {
                            completion(safeDrinks)
                        }

                    } catch {
                        print(error.localizedDescription)
                    }
            }
        }.resume()
    }
}


