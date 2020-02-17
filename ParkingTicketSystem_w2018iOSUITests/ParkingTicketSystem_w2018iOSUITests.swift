//
//  ParkingTicketSystem_w2018iOSUITests.swift
//  ParkingTicketSystem_w2018iOSUITests
//
//  Created by Nayay Sharma on 2019-03-18.
//  Copyright © 2019 Pritesh Patel. All rights reserved.
//

import XCTest

class ParkingTicketSystem_w2018iOSUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvalidLogin(){
        let username = "snayay@gmail.com"
        let password = "test"
        //Check and enter username
        let app = XCUIApplication()
        //wait for existance
        XCTAssert(app.textFields["Username"].waitForExistence(timeout: 1))
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText(username)
        //Check and enter password
        XCTAssert(app.secureTextFields["Password"].exists)
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)
        //check and click on Login button
        XCTAssert(app.buttons["Login"].exists)
        app.buttons["Login"].tap()
        //Check the alert
        XCTAssert(app.alerts.buttons["OK"].exists)
        app.alerts.buttons["OK"].tap()
    }
    
    func testRegistrationLoginExample(){
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let username = "snayay@gmail.com"
        let password = "test123$"
        let app = XCUIApplication()
        //Click on Sign up
        app.navigationBars["Login"].buttons["Sign Up"].tap()
        //Enter Email ID
        XCTAssert(app.textFields["Enter Email ID"].exists)
        app.textFields["Enter Email ID"].tap()
        app.textFields["Enter Email ID"].typeText(username)
        //Enter Pasword
        XCTAssert(app.secureTextFields["Enter Password"].exists)
        let enterPasswordSecureTextField = app.secureTextFields["Enter Password"]
        enterPasswordSecureTextField.tap()
        enterPasswordSecureTextField.typeText(password)
        //Enter Full Name
        XCTAssert(app.textFields["Enter Full Name"].exists)
        let enterFullNameTextField = app.textFields["Enter Full Name"]
        enterFullNameTextField.tap()
        enterFullNameTextField.typeText("Nayay Sharma")
        //Enter birth date
        XCTAssert(app.textFields["Enter Birthdate"].exists)
        let enterBirthdateTextField = app.textFields["Enter Birthdate"]
        enterBirthdateTextField.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["March"].swipeUp()
        datePickersQuery.pickerWheels["18"].swipeDown()
        datePickersQuery.pickerWheels["2019"].swipeDown()
        //After entering date press Done
        let doneButton = app.toolbars.matching(identifier: "Toolbar").buttons["Done"]
        doneButton.tap()
        //Click on Signu up
        app.buttons["Sign Up"].tap()
        //Enter passord to Sign in
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText(password)
        //Click on login
        app.buttons["Login"].tap()
        //wait for next page
        expectation(for: NSPredicate(format: "exists ==1"), evaluatedWith: app.tables/*@START_MENU_TOKEN@*/.staticTexts["Add Ticket"]/*[[".cells.staticTexts[\"Add Ticket\"]",".staticTexts[\"Add Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
        //Click on Add ticket
        XCTAssert( app.tables/*@START_MENU_TOKEN@*/.staticTexts["Add Ticket"]/*[[".cells.staticTexts[\"Add Ticket\"]",".staticTexts[\"Add Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Add Ticket"]/*[[".cells.staticTexts[\"Add Ticket\"]",".staticTexts[\"Add Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //Enter Vehicle Number
        let enterVehicleNumberTextField = app.textFields["Enter Vehicle Number"]
        enterVehicleNumberTextField.tap()
        enterVehicleNumberTextField.typeText("PB02AB5105")
        //Enter Car Make
        XCTAssert(app.textFields["Car Make"].exists)
        app.textFields["Car Make"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Acura"]/*[[".pickers.pickerWheels[\"Acura\"]",".pickerWheels[\"Acura\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        doneButton.tap()
        //Enter Car Color
        let enterCarColorTextField = app.textFields["Enter Car Color"]
        enterCarColorTextField.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["White"]/*[[".pickers.pickerWheels[\"White\"]",".pickerWheels[\"White\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        doneButton.tap()
        //Enter Parkin time
        app/*@START_MENU_TOKEN@*/.buttons["1 Hr."]/*[[".segmentedControls.buttons[\"1 Hr.\"]",".buttons[\"1 Hr.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //Enter Parking Lane
        app.textFields["Enter Parking Lane"].tap()
        doneButton.tap()
        //Enter Parking Spot
        app.textFields["Enter Parking Spot Number"].tap()
        doneButton.tap()
        //Enter Payment Method
        app.textFields["Enter Payment Method"].tap()
        doneButton.tap()
        //Click on save
        app.navigationBars["Add Ticket"].buttons["save"].tap()
        //Click on yes
        app.alerts["Add Ticket"].buttons["Yes"].tap()
        //wait for next page
        expectation(for: NSPredicate(format: "exists ==1"), evaluatedWith: app.navigationBars["Print Ticket"], handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        //Click on print
        app.navigationBars["Print Ticket"].buttons["Main"].tap()
        //Click on log out
        app.navigationBars["Main"].buttons["Logout"].tap()
    }
    /*let screen = XCUIScreen.main
     let fullscreenshot = screen.screenshot()
     let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
     fullScreenshotAttachment.lifetime = .keepAlways
     add(fullScreenshotAttachment)*/

}
