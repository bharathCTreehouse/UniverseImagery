//
//  UniverseImageryEarthDataTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseImageryEarthDataTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testCreationOfUniverseImageryEarthData() {
        
        let earthData: UniverseImageryEarthData? = UniverseImagerySampleJSONReader.earthImageryAPIResult()
        XCTAssertNotNil(earthData)
        XCTAssertTrue(earthData!.id == "LC8_L1T_TOA/LC81270592014035LGN00")
        XCTAssertTrue(earthData!.url == "https://earthengine.googleapis.com/api/thumb?thumbid=1e37797ab6e6638b5a0d02392acb479f&token=5595cbdbfcd50de74a43c7689bf060e0")
    }
}
