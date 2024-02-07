import SwiftUI
import RealmSwift

struct SingleDrinkView: View {
    //@Inject
    @StateObject var selectedDrinkViewModel: SelectedDrinkViewModel
    var realm = RealmManager.sharedInstance
    
    init (selectedDrink: Drink) {
        self._selectedDrinkViewModel = StateObject(wrappedValue: SelectedDrinkViewModel(selectedDrink: selectedDrink))
    }
    
    var body: some View {
        if let selectedDrink = selectedDrinkViewModel.selectedDrink {
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
//            .overlay {
//                if realm.showSuccessToast {
//                    ToastView(image: "checkmark", message: "Your drink has been added to your favorites")
//                }
//                if realm.showRemoveToast {
//                    ToastView(image: "checkmark", message: "Your drink has been removed from your favorites")
//                }
//            }
        } else {
            VStack {
                ProgressView()
                Text("Hang tight...")
                Text("We're getting you some ingredients...")
            }
        }
    }
}

extension SingleDrinkView {
    @ViewBuilder
    func categoryAndDetailRow(category: String, description: String) -> some View {
        Text(category)
            .font(.system(.title2, design: .default, weight: .bold))
        Text(description)
            .multilineTextAlignment(.leading)
    }
    
    func addToFavoriteButton(isFavorite: Bool?) -> some View {
        Button(action: {
            if let isFavorite {
                if isFavorite {
                    //remove from realm
                    setUpFavoriteDrink()
                    selectedDrinkViewModel.selectedDrink?.isFavorite = false
                    realm.delete(object: selectedDrinkViewModel.favoriteDrink)
                }
            } else {
                saveToRealm()
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
    //MARK: Move logic to selectedDrinkViewModel
    private func saveToRealm() {
        setUpFavoriteDrink()
        selectedDrinkViewModel.selectedDrink?.isFavorite = true
//        realm.save(drink: selectedDrinkViewModel.favoriteDrink)
        realm.save(object: selectedDrinkViewModel.favoriteDrink)
    }
    
    private func setUpFavoriteDrink() {
        selectedDrinkViewModel.favoriteDrink.drinkName = selectedDrinkViewModel.selectedDrink?.drinkName ?? "-"
        selectedDrinkViewModel.favoriteDrink.image = selectedDrinkViewModel.selectedDrink?.image ?? "-"
        selectedDrinkViewModel.favoriteDrink.category = selectedDrinkViewModel.selectedDrink?.category ?? "-"
        selectedDrinkViewModel.favoriteDrink.glass = selectedDrinkViewModel.selectedDrink?.glass
        selectedDrinkViewModel.favoriteDrink.instructions = selectedDrinkViewModel.selectedDrink?.instructions
        selectedDrinkViewModel.favoriteDrink.isFavourite = true
    }
    
}
