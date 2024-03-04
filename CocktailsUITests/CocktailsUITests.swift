//
//  CocktailsUITests.swift
//  CocktailsUITests
//
//  Created by Sthembiso Ndhlazi on 2023/10/08.
//

import XCTest

final class CocktailsUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLandingScreenExists() {
        launchApp()
        verifyStaticTextExists("Cocktails")
        waitForExpectations(timeout: 10)
    }
    
    func testNonAlcoholicViewHasData() {
        launchApp()
        pressButton(withTitle: "Non-Alcoholic")
        verifyStaticTextExists("Afterglow")
        waitForExpectations(timeout: 10)
    }
    
    func testAlcoholicViewHasData() {
        launchApp()
        verifyStaticTextExists("252")
        waitForExpectations(timeout: 10)
    }
    
    func testFavoritesViewHasData() {
        uninstall(name: "Cocktails")
        launchApp()
        addDrinkToFavorites(drinkName: "252")
        pressButton(withTitle: "My favourites")
        verifyStaticTextExists("252")
        waitForExpectations(timeout: 10)
    }
    
    func testSelectedItemHasDetailedData() {
        launchApp()
        //Wait for the drinks to return before tapping on the drink title, the test fails if your netwprk is trash
        Thread.sleep(forTimeInterval: 10)
        tapStaticText(withTitle: "252")
        let textsExist = verifyTextsExist(texts: ["Glass type",
                                                  "Drink name",
                                                  "Drink category",
                                                  "Instructions",
                                                  "Shot"])
        XCTAssertTrue(textsExist)
    }
    
    
    func launchApp() {
        app.launch()
    }
    
    func verifyStaticTextExists(_ text: String) {
        let staticText = app.staticTexts[text]
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectation(for: existsPredicate, evaluatedWith: staticText, handler: nil)
    }
    
    func pressButton(withTitle title: String) {
        let button = app.buttons.matching(NSPredicate(format: "label == %@", title)).firstMatch
        XCTAssertTrue(button.exists, "Button with title '\(title)' does not exist")
        button.tap()
    }
    
    func addDrinkToFavorites(drinkName: String) {
        Thread.sleep(forTimeInterval: 10)
        tapStaticText(withTitle: drinkName)
        pressButton(withTitle: "Add to favorites")
        pressButton(withTitle: "Back")
    }
    
    func tapStaticText(withTitle title: String) {
        let staticText = app.staticTexts[title]
        XCTAssertTrue(staticText.exists, "Static text with title '\(title)' does not exist in the list")
        staticText.tap()
    }
    
    func verifyTextsExist(texts: [String]) -> Bool {
        for text in texts {
            let element = app.staticTexts[text]
            if !element.exists {
                // If any text does not exist, return false
                return false
            }
        }
        // All texts exist
        return true
    }
    
    func uninstall(name: String? = nil) {
        XCUIApplication().terminate()
        
        let timeout = TimeInterval(5)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        // get the app name
        let appName: String
        if let name = name {
            appName = name
        } else {
            let uiTestRunnerName = Bundle.main.infoDictionary?["CFBundleName"] as! String
            appName = uiTestRunnerName.replacingOccurrences(of: "UITests-Runner", with: "")
        }
        
        // get the app icon and press on it so we can get that action dialog
        let appIcon = springboard.icons[appName]
        if appIcon.waitForExistence(timeout: timeout) {
            appIcon.press(forDuration: 1)
        } else {
            XCTFail("Failed to find app icon named \(appName)")
        }
        //press remove app if its there
        let removeAppButton = springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: timeout) {
            removeAppButton.tap()
        } else {
            XCTFail("Failed to find 'Remove App'")
        }
        //press delete app  if its there
        let deleteAppButton = springboard.alerts.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: timeout) {
            deleteAppButton.tap()
        } else {
            XCTFail("Failed to find 'Delete App'")
        }
        //delete the app if its there
        let finalDeleteButton = springboard.alerts.buttons["Delete"]
        if finalDeleteButton.waitForExistence(timeout: timeout) {
            finalDeleteButton.tap()
        } else {
            XCTFail("Failed to find 'Delete'")
        }
    }
}
