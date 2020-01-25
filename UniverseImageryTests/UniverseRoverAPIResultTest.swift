//
//  UniverseRoverAPIResultTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseRoverAPIResultTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testFormationOfRoverAPIResult() {
        
        let roverAPIResult: UniverseRoverAPIResult? = UniverseImagerySampleJSONReader.roverImageryAPIResult()
        XCTAssertNotNil(roverAPIResult)
        XCTAssertFalse(roverAPIResult!.photos.isEmpty)
        
        let photo: UniverseImageryRoverData = roverAPIResult!.photos.first!
        XCTAssertTrue(photo.id == 727)
        XCTAssertTrue(photo.earthDate == "2012-08-06")
        XCTAssertTrue(photo.url == "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00000/opgs/edr/fcam/FRA_397502305EDR_D0010000AUT_04096M_.JPG")


    }
}
