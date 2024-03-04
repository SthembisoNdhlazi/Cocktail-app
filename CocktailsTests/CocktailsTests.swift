//
//  CocktailsTests.swift
//  CocktailsTests
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import XCTest
@testable import Cocktails
@testable import ReusableComponents

final class CocktailsTests: XCTestCase {
    var alcoholicDrinksViewModel: AlcoholicDrinksViewModel!
    var nonAlcoholicDrinksViewModel: NonAlcoholicDrinksViewModel!
    var selectedDrinkViewModel: SelectedItemViewModel!
    var favoriteDrinksViewModel: FavoriteDrinksViewModel!
    var drinksRepository: DrinksRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        drinksRepository = DrinksRepository()
        alcoholicDrinksViewModel = AlcoholicDrinksViewModel(drinksRepository: drinksRepository)
        nonAlcoholicDrinksViewModel = NonAlcoholicDrinksViewModel(drinksRepository: drinksRepository)
        selectedDrinkViewModel = SelectedItemViewModel(selectedItem: Item(id: "15288",
                                                                          drinkName: "252",
                                                                          image: "www.thecocktaildb.com/images/media/drink/rtpxqw1468877562.jpg",
                                                                          category: "Alcoholics",
                                                                          isFavorite: true))
        favoriteDrinksViewModel = FavoriteDrinksViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testAlcoholicViewModelHasItems () {
        let expectation = XCTestExpectation(description: "Items are fetched")
        // Wait for a certain period to allow the items to be fetched
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            // Fulfill the expectation when the items are fetched
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(alcoholicDrinksViewModel.items.count != 0, "Items array should not be empty")
    }
    
    func testNonAlcoholicViewModelHasItems () {
        let expectation = XCTestExpectation(description: "Items are fetched")
        // Wait for a certain period to allow the items to be fetched
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            // Fulfill the expectation when the items are fetched
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(nonAlcoholicDrinksViewModel.items.count != 0, "Items array should not be empty")
    }
    
    func testSelectedItemIsNotNil () {
        XCTAssertTrue(selectedDrinkViewModel.selectedItem != nil)
    }
    
    func testFavoriteDrinksViewModelHasItems () {
        let expectation = XCTestExpectation(description: "Items are fetched")
        // Wait for a certain period to allow the items to be fetched
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            // Fulfill the expectation when the items are fetched
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6.0)
        XCTAssertFalse(favoriteDrinksViewModel.items.count == 0, "Items array should not be empty")
    }
}
