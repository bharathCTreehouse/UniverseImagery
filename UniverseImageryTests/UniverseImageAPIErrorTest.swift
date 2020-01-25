//
//  UniverseImageAPIErrorTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseImageAPIErrorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testAllErrorDescriptions() {
        
        var err: UniverseImageAPIError = .invalidResponse
        XCTAssertTrue(err.localizedDescription == "Invalid response. Please try again")
        
        err = .noResponse
        XCTAssertTrue(err.localizedDescription == "Failed to receive reponse in time. Please try again after a while")
        
        err = .invalidData
        XCTAssertTrue(err.localizedDescription == "Unreadable data received")
        
        err = .noData
        XCTAssertTrue(err.localizedDescription == "No data received")
        
        err = .invalidURL
        XCTAssertTrue(err.localizedDescription == "Could not connect to the server. Please try again after some time")
        
        err = .parsingFailure
        XCTAssertTrue(err.localizedDescription == "Unreadable data received")
    }
}
