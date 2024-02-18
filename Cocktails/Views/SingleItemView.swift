import SwiftUI
import RealmSwift
import Kingfisher

struct SingleItemView: View {
    //MARK: Make this more generic: SelectedItemViewModel instead of singleDrinkViewModel
    @StateObject var selectedItemViewModel: SelectedItemViewModel
    var realm = RealmManager.sharedInstance
//    @Environment(\.dismiss) var dismiss
    
    init (selectedItem: Item, networking: CocktailsNetworking? = nil) {
        self._selectedItemViewModel = StateObject(wrappedValue: SelectedItemViewModel(selectedItem: selectedItem, networking: networking ?? CocktailsServiceCalls()))
    }
    
    var body: some View {
        if let selectedDrink = selectedItemViewModel.selectedItem {
            ScrollView {
                VStack {
                    if let imageURL = URL(string: selectedDrink.image) {
                        KFImage(imageURL)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                            .padding(.top)
                    } else {
                        ProgressView()
                            .frame(width: 250, height: 250)
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

extension SingleItemView {
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
                    selectedItemViewModel.selectedItem?.isFavorite = false
                    realm.delete(object: selectedItemViewModel.favoriteDrink)
                } else {
                    saveToRealm()
                }
            } else {
                saveToRealm()
            }
//            dismiss()
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


extension SingleItemView {
    //MARK: Move logic to selectedDrinkViewModel
    private func saveToRealm() {
        setUpFavoriteDrink()
        selectedItemViewModel.selectedItem?.isFavorite = true
//        realm.save(drink: selectedDrinkViewModel.favoriteDrink)
        realm.save(object: selectedItemViewModel.favoriteDrink)
    }
    
    private func setUpFavoriteDrink() {
        let selectedItem = selectedItemViewModel.selectedItem
        selectedItemViewModel.favoriteDrink = FavoriteDrink(id: selectedItem?.id ?? UUID().uuidString,
                                                             drinkName: selectedItem?.drinkName ?? "",
                                                             glass: selectedItem?.glass,
                                                             instructions: selectedItem?.instructions,
                                                             image: selectedItem?.image ?? "",
                                                             category: selectedItem?.category,
                                                             isFavourite: true)
    }
    
}
