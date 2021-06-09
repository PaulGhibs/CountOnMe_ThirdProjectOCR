//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import P5_01_Xcode

class P5_01_XcodeTests: XCTestCase {
    var calculator: Brainiac!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        calculator = Brainiac()
    }

    
    override func tearDown() {
        calculator = nil
    }

    func testGivenForStringNumber_WhenAddingNumber1_ThenNumberisShowed() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let stringNumber = "1"
        calculator.addStringToNumber(stringNumber: stringNumber)
        XCTAssertEqual(calculator.elementTextView, "1")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
