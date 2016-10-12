//
//  TooDoAppUITests.swift
//  TooDoAppUITests
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SBTUITestTunnel

class TooDoAppUITests: XCTestCase {
        
    var app:SBTUITunneledApplication!
    
    override func setUp() {
        XCUIApplication().terminate()
        super.setUp()
        app = SBTUITunneledApplication()
        app.launchTunnel()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

