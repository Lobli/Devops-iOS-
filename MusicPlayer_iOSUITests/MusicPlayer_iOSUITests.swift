//
//  MusicPlayer_iOSUITests.swift
//  MusicPlayer_iOSUITests
//
//  Created by Lobler Ádám on 2018. 10. 07..
//  Copyright © 2018. Lobler Ádám. All rights reserved.
//

import XCTest

class MusicPlayer_iOSUITests: XCTestCase {

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

    func testOpenLibrary() {
        let app = XCUIApplication()
        app.buttons["Group 3"].tap()
        app.tables.buttons["back"].tap()
    }
    
    func testAdjustVolume() {
        let button = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .button).element
        button.swipeLeft()
        button.swipeRight()
        button.swipeLeft()
    }
    
//    func testPlayAndPause() {
//        let app = XCUIApplication()
//        app.buttons["play button"].tap()
//        app.buttons["pause button"].tap()
//    }
    
//    func testPlayNext_Previous() {
//        let app = XCUIApplication()
//        let nextButton = app.buttons["next"]
//        nextButton.tap()
//        let previousButton = app.buttons["previous"]
//        previousButton.tap()
//        app.buttons["play button"].tap()
//        nextButton.tap()
//        previousButton.tap()
//        app.buttons["pause button"].tap()
//        XCUIDevice.shared.orientation = .landscapeRight
//        XCUIDevice.shared.orientation = .faceUp
//    }
    
    func testOrientations(){
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .faceDown
        XCUIDevice.shared.orientation = .portraitUpsideDown
        
    }
    
    

}
