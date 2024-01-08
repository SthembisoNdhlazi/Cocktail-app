import SwiftUI
import RealmSwift

struct SingleDrinkView: View {
    @ObservedObject var selectedDrinkViewModel: SelectedDrinkViewModel
//    @Environment(\.realm) var realm
    @ObservedRealmObject var favoriteDrink: FavoriteDrink = FavoriteDrink()
    @ObservedResults(FavoriteDrink.self) var favoriteDrinks
    @StateObject var realm = RealmPersistence()
    
    var body: some View {
        if let selectedDrink = selectedDrinkViewModel.detailedDrink {
            ScrollView {
                VStack {
                    if let imageURL = URL(string: selectedDrink.image) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 250, height: 250)
                                .cornerRadius(15)
                                .padding(.top)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 250, height: 250)
                        }
                    }
                }
                .padding()
                
                VStack (alignment: .leading, spacing: 10) {
                    
                    categoryAndDetailRow(category: "Drink name", description: selectedDrink.drinkName)
                    
                    if let glass = selectedDrink.glass {
                        categoryAndDetailRow(category: "Glass type", description: glass)
                    }
                    
                    if let category = selectedDrink.category {
                        categoryAndDetailRow(category: "Drink category", description: category)
                    }
                    
                    if let instructions = selectedDrink.instructions {
                        categoryAndDetailRow(category: "Instructions", description: instructions)
                    }
                    
                    addToFavoriteButton(isFavorite: selectedDrink.isFavorite)
                }
                .padding()
                
            }
            .navigationTitle(selectedDrink.drinkName)
            .scrollIndicators(.hidden)
            .overlay {
                if realm.showSuccessToast {
                    ToastView(image: "checkmark", message: "Your drink has been added to your favorites")
                }
                if realm.showRemoveToast {
                    ToastView(image: "checkmark", message: "Your drink has been removed from your favorites")
                }
            }
        } else {
            VStack {
                ProgressView()
                Text("Hang tight...")
                Text("We're getting you some ingredients...")
            }
        }
    }
}

//struct SingleDrinkView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let selectedDrinkViewModel = SelectedDrinkViewModel()
//        SingleDrinkView(selectedDrinkViewModel: selectedDrinkViewModel)
//            .onAppear {
//                selectedDrinkViewModel.detailedDrink = Drink(id: "1",
//                                                             drinkName: "Mojito",
//                                                             glass: "Normal glass",
//                                                             instructions: "Drink",
//                                                             image: "",
//                                                             category: "")
//            }
//    }
//}

extension SingleDrinkView {
    @ViewBuilder
    func categoryAndDetailRow(category: String, description: String) -> some View {
        Text(category)
            .font(.system(.title2, design: .default, weight: .bold))
        Text(description)
            .multilineTextAlignment(.leading)
    }
    //MARK: Move logic to selectedDrinkViewModel
    func addToFavoriteButton(isFavorite: Bool?) -> some View {
        Button(action: {
            if let isFavorite {
                if isFavorite {
                    //remove from realm
                    selectedDrinkViewModel.detailedDrink?.isFavorite = false
                }
            } else {
                favoriteDrink.drinkName = selectedDrinkViewModel.detailedDrink?.drinkName ?? ""
                favoriteDrink.image = selectedDrinkViewModel.detailedDrink?.image ?? ""
                favoriteDrink.category = selectedDrinkViewModel.detailedDrink?.category ?? ""
                favoriteDrink.glass = selectedDrinkViewModel.detailedDrink?.glass
                favoriteDrink.instructions = selectedDrinkViewModel.detailedDrink?.instructions
                favoriteDrink.isFavourite = true
                selectedDrinkViewModel.detailedDrink?.isFavorite = true
                realm.save(drink: favoriteDrink)
            }
        }) {
            
            Text(isFavorite ?? false ? "Remove from favorites" : "Add to favorites")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
        .background(Color.black)
        .cornerRadius(25)
        .padding()
    }
}


extension SingleDrinkView {

}
