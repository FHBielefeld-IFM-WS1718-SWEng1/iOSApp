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
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        XCTAssertEqual(eMailTextField.placeholderValue, "E-Mail")
        XCTAssertTrue(eMailTextField.exists, "Text field doesn't exist")
        eMailTextField.tap()
        eMailTextField.typeText("testValue")
        XCTAssertEqual(eMailTextField.description, "\"testValue\" TextField")
        
    }
    func testPasswortTextField() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        XCTAssertEqual(passwortSecureTextField.placeholderValue, "Passwort")
        XCTAssertTrue(passwortSecureTextField.exists, "Text field doesn't exist")
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("testValue")
        
    }
    
    func testRegisterMailTextField() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let eMailTextField = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element.textFields["E-Mail"]
        
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
        
        let passwortSecureTextField = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element.secureTextFields["Passwort"]
        XCTAssertEqual(passwortSecureTextField.placeholderValue, "Passwort")
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("testValue")
        
        XCTAssertTrue(passwortSecureTextField.exists, "Text field doesn't exist")
        
    }
    
    func testRegisterPasswortWiederholenTextField() {
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let passwortWiederholenTextField = app.secureTextFields["Passwort wiederholen"]
        XCTAssertEqual(passwortWiederholenTextField.placeholderValue, "Passwort wiederholen")
        XCTAssertTrue(passwortWiederholenTextField.exists, "Text field doesn't exist")
        passwortWiederholenTextField.tap()
        passwortWiederholenTextField.typeText("testValue")
    }
    
    func testLoginWithCorrectData() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("Dario")
        
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testLoginWithWrongData() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("Dario")
        
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("tefewst")
        app.buttons["ANMELDEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testLoginWithoutPassword() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("Dario")
        
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("")
        app.buttons["ANMELDEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testLoginWithoutEverything() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("")
        
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("")
        app.buttons["ANMELDEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterWithCorrectData() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fa")
        
        let benutzernameTextField = app.textFields["Benutzername"]
        benutzernameTextField.tap()
        benutzernameTextField.tap()
        benutzernameTextField.typeText("fddf")
        
        let passwortSecureTextField = element.secureTextFields["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        
        let passwortWiederholenSecureTextField = app.secureTextFields["Passwort wiederholen"]
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.typeText("test")
        app.buttons["REGISTRIERUNG ABSCHLIESSEN"].tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterWithoutMatchingPasswords() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fa")
        
        let benutzernameTextField = app.textFields["Benutzername"]
        benutzernameTextField.tap()
        benutzernameTextField.tap()
        benutzernameTextField.typeText("fddf")
        
        let passwortSecureTextField = element.secureTextFields["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        
        let passwortWiederholenSecureTextField = app.secureTextFields["Passwort wiederholen"]
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.typeText("false")
        app.buttons["REGISTRIERUNG ABSCHLIESSEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
   
    
    func testRegisterWithoutUsername() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fa")
        
        let benutzernameTextField = app.textFields["Benutzername"]
        benutzernameTextField.tap()
        benutzernameTextField.tap()
        benutzernameTextField.typeText("")
        
        let passwortSecureTextField = element.secureTextFields["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        
        let passwortWiederholenSecureTextField = app.secureTextFields["Passwort wiederholen"]
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.typeText("test")
        app.buttons["REGISTRIERUNG ABSCHLIESSEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterWithoutPassword() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fa")
        
        let benutzernameTextField = app.textFields["Benutzername"]
        benutzernameTextField.tap()
        benutzernameTextField.tap()
        benutzernameTextField.typeText("max")
        
        let passwortSecureTextField = element.secureTextFields["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("")
        
        let passwortWiederholenSecureTextField = app.secureTextFields["Passwort wiederholen"]
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.tap()
        passwortWiederholenSecureTextField.typeText("")
        app.buttons["REGISTRIERUNG ABSCHLIESSEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
}
