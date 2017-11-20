//
//  PaplaUITests.swift
//  PaplaUITests
//
//  Created by Dario Leunig on 14.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import XCTest

class PaplaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMailTextField() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let eMailTextField = XCUIApplication().textFields["E-Mail"]
        XCTAssertEqual(eMailTextField.placeholderValue, "E-Mail")
        XCTAssertTrue(eMailTextField.exists, "Text field doesn't exist")
        eMailTextField.tap()
        eMailTextField.typeText("testValue")
        XCTAssertEqual(eMailTextField.description, "\"testValue\" TextField")
        
    }
    func testPasswortTextField() {
        
        let passwortTextField = XCUIApplication().textFields["Passwort"]
        XCTAssertEqual(passwortTextField.placeholderValue, "Passwort")
        XCTAssertTrue(passwortTextField.exists, "Text field doesn't exist")
        passwortTextField.tap()
        passwortTextField.typeText("testValue")
        XCTAssertEqual(passwortTextField.description, "\"testValue\" TextField")
        
    }
    
    func testRegisterMailTextField() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        let eMailTextField = XCUIApplication().textFields["E-Mail"]
        XCTAssertEqual(eMailTextField.placeholderValue, "E-Mail")
        XCTAssertTrue(eMailTextField.exists, "Text field doesn't exist")
        eMailTextField.tap()
        eMailTextField.typeText("testValue")
        XCTAssertEqual(eMailTextField.description, "\"testValue\" TextField")
        
        
    }
    
    func testRegisterBenutzernameTextField() {
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        let benutzernameTextField = XCUIApplication().textFields["Benutzername"]
        XCTAssertEqual(benutzernameTextField.placeholderValue, "Benutzername")
        XCTAssertTrue(benutzernameTextField.exists, "Text field doesn't exist")
        benutzernameTextField.tap()
        benutzernameTextField.typeText("testValue")
        XCTAssertEqual(benutzernameTextField.description, "\"testValue\" TextField")
    }
    
    func testRegisterPasswortTextField(){
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        let passwortTextField = XCUIApplication().textFields["Passwort"]
        XCTAssertEqual(passwortTextField.placeholderValue, "Passwort")
        XCTAssertTrue(passwortTextField.exists, "Text field doesn't exist")
        passwortTextField.tap()
        passwortTextField.typeText("testValue")
        XCTAssertEqual(passwortTextField.description, "\"testValue\" TextField")
    }
    
    func testRegisterPasswortWiederholenTextField() {
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        let passwortWiederholenTextField = XCUIApplication().textFields["Passwort wiederholen"]
        XCTAssertEqual(passwortWiederholenTextField.placeholderValue, "Passwort wiederholen")
        XCTAssertTrue(passwortWiederholenTextField.exists, "Text field doesn't exist")
        passwortWiederholenTextField.tap()
        passwortWiederholenTextField.typeText("testValue")
        XCTAssertEqual(passwortWiederholenTextField.description, "\"testValue\" TextField")
    }
    
    
}
