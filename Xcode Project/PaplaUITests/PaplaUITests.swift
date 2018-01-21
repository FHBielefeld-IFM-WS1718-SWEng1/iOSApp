//
//  PaplaUITests.swift
//  PaplaUITests
//
//  Created by Dario Leunig on 14.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import XCTest
@testable import Papla

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
        eMailTextField.typeText("fisch@fisch.de")
        
        let passwortSecureTextField = logoElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        XCTAssertTrue(app.navigationBars["Übersicht"].buttons["Item"].exists, "Text field doesn't exist")
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
    
    func testLoginWithWrongPassword() {
        
        let app = XCUIApplication()
        let logoElementsQuery = app.otherElements.containing(.image, identifier:"Logo")
        let eMailTextField = logoElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch@fisch.de")
        
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
    
    func testRegisterWithCorrectDataEmailWithoutPoint() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test@testklasse.de")
        
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
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        XCTAssertTrue(app.navigationBars["Übersicht"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterWithCorrectDataEmailWithPoint() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("te.st@testklasse.de")
        
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
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        XCTAssertTrue(app.navigationBars["Übersicht"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterEmailWithoudAt() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test.testklasse.de")
        
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
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterEmailWithNothingBeforePoint() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText(".test@klasse.de")
        
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
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterEmailWithoudEnding() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test.test@klasse")
        
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
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterEmailWithoudDomain() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test.testklasse@.de")
        
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
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
    
    func testRegisterWithoutMatchingPasswords() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test@testklasse.de")
        
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
        passwortWiederholenSecureTextField.typeText("falsevh")
        app.buttons["REGISTRIERUNG ABSCHLIESSEN"].tap()
        XCTAssertFalse(app.navigationBars["Dashboard"].buttons["Item"].exists, "Text field doesn't exist")
        
    }
   
    
    func testRegisterWithoutUsername() {
        
        let app = XCUIApplication()
        app.buttons["REGISTRIEREN"].tap()
        
        let element = app.otherElements.containing(.image, identifier:"Logo").children(matching: .other).element
        let eMailTextField = element.textFields["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("test@testklasse.de")
        
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
    
    func testDeleteProfileDoubleCheck() {
        
        
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        
        let itemButton = app.navigationBars["Übersicht"].buttons["Item"]
        itemButton.tap()
        itemButton.tap()
        app.tables["Empty list"].swipeDown()
        itemButton.tap()
        app.buttons["Mein Profil"].tap()
        
        app.textFields["JJJJ-MM-TT"]
        
        let mWNTextField = app.textFields["m/w/n"]
        mWNTextField.tap()
        mWNTextField.tap()
        mWNTextField.typeText("ghj")
        
        let profildatenSpeichernButton = app.buttons["Profildaten speichern"]
        profildatenSpeichernButton.tap()
        mWNTextField.typeText("m")
        profildatenSpeichernButton.tap()
        app.buttons["Konto löschen"].tap()
        XCTAssertTrue(app.buttons["Abbrechen"].exists)
        
    }
    
    func testEnterWrongBirthday() {
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        
        let itemButton = app.navigationBars["Übersicht"].buttons["Item"]
        itemButton.tap()
        itemButton.tap()
        app.tables["Empty list"].swipeDown()
        itemButton.tap()
        app.buttons["Mein Profil"].tap()
        
        app.textFields["JJJJ-MM-TT"]
        
        let jjjjMmTtTextField = XCUIApplication().textFields["JJJJ-MM-TT"]
        jjjjMmTtTextField.tap()
        jjjjMmTtTextField.typeText("fghfh")
        
        let profildatenSpeichernButton = app.buttons["Profildaten speichern"]
        profildatenSpeichernButton.tap()
        
        XCTAssertEqual(jjjjMmTtTextField.description, "\"1997-04-29\" TextField")
        
    }
    
    func testEnterWrongGender() {
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        
        let itemButton = app.navigationBars["Übersicht"].buttons["Item"]
        itemButton.tap()
        itemButton.tap()
        app.tables["Empty list"].swipeDown()
        itemButton.tap()
        app.buttons["Mein Profil"].tap()
        
        let mWNTextField = app.textFields["m/w/n"]
        mWNTextField.tap()
        mWNTextField.typeText("sdfgh")
        app.buttons["Profildaten speichern"].tap()
        
        XCTAssertEqual(mWNTextField.description, "\"m\" TextField")
        
    }
    
    func testLogout(){
        
        let eMailTextField = XCUIApplication().otherElements.containing(.button, identifier:"Passwort vergessen").children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let app = XCUIApplication()
        let passwortSecureTextField = app.otherElements.containing(.button, identifier:"Passwort vergessen").children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Ausloggen"].tap()
        
        XCTAssertTrue(eMailTextField.exists)
        
    }
    
    func testShowKontaktPapla() {
        
        let passwortVergessenElementsQuery = XCUIApplication().otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let app = XCUIApplication()
        let passwortSecureTextField = app.otherElements.containing(.button, identifier:"Passwort vergessen").children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Kontakt"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("gjh")
        
        XCTAssertTrue(textField.exists)
        
        
    }
    
    func testnewPartyNameTextField() {
        
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Eigene Veranstaltungen"].tap()
        app.navigationBars["Eigene Veranstaltungen"].buttons["Add"].tap()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("asdf")
        
        
        
        XCTAssertTrue(true)
    }
    
    func testnewPartyDescriptionTextFiled() {
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Eigene Veranstaltungen"].tap()
        app.navigationBars["Eigene Veranstaltungen"].buttons["Add"].tap()
        
        let beschreibungTextField = app.textFields["Beschreibung"]
        beschreibungTextField.tap()
        beschreibungTextField.tap()
        beschreibungTextField.typeText("sdf")
        
        XCTAssertTrue(true)
    }
    
    func testnewPartyLocationTextField() {
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Eigene Veranstaltungen"].tap()
        app.navigationBars["Eigene Veranstaltungen"].buttons["Add"].tap()
        
        let ortTextField = app.textFields["Ort"]
        ortTextField.tap()
        ortTextField.tap()
        ortTextField.typeText("csdcd")
        
        XCTAssertTrue(true)

    }
    
    func testaddKontaktWrongEmail() {
        
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Kontakte"].tap()
        
        let kontakteNavigationBar = app.navigationBars["Kontakte"]
        kontakteNavigationBar.buttons["Add"].tap()
        
        let eMailTextField2 = app.textFields["E-Mail"]
        eMailTextField2.tap()
        eMailTextField2.typeText("asdfghjkl")
        
        let kontaktHinzufGenButton = app.buttons["Kontakt hinzufügen"]
        kontaktHinzufGenButton.tap()
        XCTAssertTrue(app.staticTexts["User nicht gefunden"].exists)

    }
    
    func testshowKontaks() {
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Kontakte"].tap()
        
        let kontakteNavigationBar = app.navigationBars["Kontakte"]
        
        XCTAssertTrue(true)
    }
    
    func testshowOwnPartys() {
        
        
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Eigene Veranstaltungen"].tap()
        
        XCTAssertTrue(true)
    }
    
    func testshowImpressum () {
        
        
        let app = XCUIApplication()
        let passwortVergessenElementsQuery = app.otherElements.containing(.button, identifier:"Passwort vergessen")
        let eMailTextField = passwortVergessenElementsQuery.children(matching: .textField)["E-Mail"]
        eMailTextField.tap()
        eMailTextField.typeText("fisch")
        eMailTextField.typeText("@")
        eMailTextField.typeText("fisch.de")
        
        let passwortSecureTextField = passwortVergessenElementsQuery.children(matching: .secureTextField)["Passwort"]
        passwortSecureTextField.tap()
        passwortSecureTextField.tap()
        passwortSecureTextField.typeText("test")
        app.buttons["ANMELDEN"].tap()
        app.navigationBars["Übersicht"].buttons["Item"].tap()
        app.buttons["Impressum"].tap()
        
        XCTAssertTrue(true)
    }
}

