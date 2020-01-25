//
//  UniverseImageryEndpointTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseImageryEndpointTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testUrlPathAndQueryItems() {
        
        //Rover
        var roverEndPoint: UniverseImageryEndpoint = .fetchRoverImage(page: 1, fetchCriteria: .earthDate("2020-01-01"), cameraType: nil)
        XCTAssertTrue(roverEndPoint.urlPath == "/mars-photos/api/v1/rovers/curiosity/photos/")
        XCTAssertTrue(roverEndPoint.urlQueryItems.count == 3)
        roverEndPoint = .fetchRoverImage(page: 1, fetchCriteria: .earthDate("2020-01-01"), cameraType: .CHEMCAM)
        XCTAssertTrue(roverEndPoint.urlQueryItems.count == 4)
        
        //Earth
        var earthEndPoint: UniverseImageryEndpoint = .fetchEarthImage(latitude: 20.0, longitude: 10.0, date: "2020-01-01")
        XCTAssertTrue(earthEndPoint.urlPath == "/planetary/earth/imagery/")
        XCTAssertTrue(earthEndPoint.urlQueryItems.count == 4)
        earthEndPoint = .fetchEarthImage(latitude: 20.0, longitude: 10.0, date: nil)
        XCTAssertTrue(earthEndPoint.urlQueryItems.count == 3)
        
        //Test base
        XCTAssertTrue(earthEndPoint.urlBase == "https://api.nasa.gov/")
        XCTAssertNotNil(earthEndPoint.urlRequest)
    }
}
