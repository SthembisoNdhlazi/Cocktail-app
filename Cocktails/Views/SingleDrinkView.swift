import SwiftUI

struct SingleDrinkView: View {
    @ObservedObject var selectedDrinkViewModel: SelectedDrinkViewModel
    
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
                VStack {
                    Spacer()
                    HStack {
                        Text("Drink name")
                            .font(.system(.title2, design: .default, weight: .bold))
                            .padding()
                        Spacer()
                        Text(selectedDrink.drinkName)
                            .padding()
                    }
                    if let glass = selectedDrink.glass {
                        HStack {
                            Text("Glass type")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(glass)
                                .padding()
                        }
                    }
                    
                    if let category = selectedDrink.category {
                        HStack {
                            Text("Drink category")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(category)
                                .padding()
                        }
                    }
                    
                    if let instructions = selectedDrink.instructions {
                        HStack {
                            Text("Instructions")
                                .font(.system(.title2, design: .default, weight: .bold))
                                .padding()
                            Spacer()
                            Text(instructions)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                    }
                    Button(action: {
                        
                    }) {
                        Text("Add to favorites")
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
            .navigationTitle(selectedDrink.drinkName)
            
        } else {
            VStack {
                ProgressView()
                Text("Hang tight...")
                Text("We're getting you some ingredients...")
            }
        }
    }
}

struct SingleDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        
        let selectedDrinkViewModel = SelectedDrinkViewModel()
        SingleDrinkView(selectedDrinkViewModel: selectedDrinkViewModel)
            .onAppear {
                selectedDrinkViewModel.detailedDrink = Drink(id: "1",
                                                             drinkName: "Mojito",
                                                             glass: "Normal glass",
                                                             instructions: "Drink",
                                                             image: "",
                                                             category: "")
            }
    }
}
