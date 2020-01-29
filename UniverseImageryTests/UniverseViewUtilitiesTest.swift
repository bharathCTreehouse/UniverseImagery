//
//  UniverseViewUtilitiesTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseViewUtilitiesTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testStateChangeOfView() {
        
        let testView: UIView = UIView()
        
        //Under test
        testView.enable(false, withAlpha: 0.3, animate: false)
        XCTAssertFalse(testView.isUserInteractionEnabled)
        XCTAssertTrue(testView.alpha != 1.0)
        
        testView.enable(true, withAlpha: 1.0, animate: false)
        XCTAssertTrue(testView.isUserInteractionEnabled)
        XCTAssertTrue(testView.alpha == 1.0)
        
    }

}
