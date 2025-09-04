//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created on 03/09/25.
//

import XCTest

final class WeatherAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
        
    func testWeatherScreenLoadsSuccessfully() {
        waitForScrollView()
        assertWeatherDetailsExist()
    }
        
    func testSearchValidCity() {
        searchCity("Sydney")
        waitForScrollView()
        XCTAssertTrue(app.staticTexts["Sydney, Australia"].exists)
        tapCancelButtonIfPresent()
    }
    
    func testSearchInvalidCity() {
        searchCity("ghk")
        let errorText = app.staticTexts["errorMessage"]
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: errorText)
        waitForExpectations(timeout: 10)
        XCTAssertTrue(errorText.exists)
    }
        
    private func waitForScrollView(timeout: TimeInterval = 10) {
        let scrollView = app.scrollViews["containerScrollView"]
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: scrollView)
        waitForExpectations(timeout: timeout)
        XCTAssertTrue(scrollView.exists)
    }
    
    private func assertWeatherDetailsExist() {
        let expectedLabels = ["Wind", "Humidity", "Cloud cover", "Feels Like", "UV Index"]
        for label in expectedLabels {
            XCTAssertTrue(app.staticTexts[label].exists, "Expected label '\(label)' not found.")
        }
    }
    
    private func searchCity(_ city: String) {
        let searchField = app.searchFields["Enter city name"]
        XCTAssertTrue(searchField.exists, "Search field not found.")
        searchField.tap()
        searchField.typeText(city)
        app.keyboards.buttons["Search"].tap()
    }
    
    private func tapCancelButtonIfPresent() {
        let cancelButton = app.navigationBars.buttons["Cancel"]
        if cancelButton.exists {
            cancelButton.tap()
        }
    }
   
}

