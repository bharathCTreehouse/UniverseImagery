//
//  UniverseRoverCameraTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseRoverCameraTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testRoverCameraDescription() {
        
        var cameraType: UniverseRoverCamera = .FHAZ
        XCTAssertTrue(cameraType.rawValue == "fhaz")
        XCTAssertTrue(cameraType.description == "Front Hazard Avoidance Camera")
        
        cameraType = .RHAZ
        XCTAssertTrue(cameraType.rawValue == "rhaz")
        XCTAssertTrue(cameraType.description == "Rear Hazard Avoidance Camera")
        
        cameraType = .MAST
        XCTAssertTrue(cameraType.rawValue == "mast")
        XCTAssertTrue(cameraType.description == "Mast Camera")
        
        cameraType = .CHEMCAM
        XCTAssertTrue(cameraType.rawValue == "chemcam")
        XCTAssertTrue(cameraType.description == "Chemistry and Camera Complex")
        
        cameraType = .MAHLI
        XCTAssertTrue(cameraType.rawValue == "mahli")
        XCTAssertTrue(cameraType.description == "Mars Hand Lens Imager")
        
        cameraType = .MARDI
        XCTAssertTrue(cameraType.rawValue == "mardi")
        XCTAssertTrue(cameraType.description == "Mars Descent Imager")
        
        cameraType = .NAVCAM
        XCTAssertTrue(cameraType.rawValue == "navcam")
        XCTAssertTrue(cameraType.description == "Navigation Camera")
        
        cameraType = .PANCAM
        XCTAssertTrue(cameraType.rawValue == "pancam")
        XCTAssertTrue(cameraType.description == "Panoramic Camera")
        
        cameraType = .MINITES
        XCTAssertTrue(cameraType.rawValue == "minites")
        XCTAssertTrue(cameraType.description == "Miniature Thermal Emission Spectrometer (Mini-TES)")
        
    }
    
    func testListOfRoverCameraTypesInDisplayableOrder() {
        
        XCTAssertTrue([UniverseRoverCamera.FHAZ, UniverseRoverCamera.RHAZ, UniverseRoverCamera.MAST, UniverseRoverCamera.CHEMCAM, UniverseRoverCamera.MAHLI, UniverseRoverCamera.MARDI, UniverseRoverCamera.NAVCAM, UniverseRoverCamera.PANCAM, UniverseRoverCamera.MINITES] == UniverseRoverCamera.completeList)
    }
}
