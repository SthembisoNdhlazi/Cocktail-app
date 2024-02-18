
protocol ItemViewable: Hashable {
    //MARK: gotta change these so they can be for all items, not drinks... Maybe add categories (the headings) as well
    
    var drinkName:String { get }
    var glass: String? { get }
    var instructions: String? { get }
    var image: String { get }
    var category:String? { get }
}
