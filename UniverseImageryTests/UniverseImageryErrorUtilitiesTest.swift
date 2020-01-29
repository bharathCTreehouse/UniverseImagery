//
//  UniverseImageryErrorUtilitiesTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseImageryErrorUtilitiesTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testErrorCausedByAPICancellation() {
        
        var err: NSError = NSError(domain: "", code: NSURLErrorCancelled, userInfo: nil)
        XCTAssertTrue(err.causedByAPICancellation)
        
        err = NSError(domain: "", code: 100, userInfo: nil)
        XCTAssertFalse(err.causedByAPICancellation)
        
        err = NSError(domain: "", code: NSUserCancelledError, userInfo: nil)
        XCTAssertTrue(err.causedByAPICancellation)
    }
}
