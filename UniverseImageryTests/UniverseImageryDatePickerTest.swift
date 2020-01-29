//
//  UniverseImageryDatePickerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseImageryDatePickerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testSetup() {
        let datePicker = UniverseImageryDatePicker()
        XCTAssertFalse(datePicker.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(datePicker.datePickerMode == .date)
    }
}
