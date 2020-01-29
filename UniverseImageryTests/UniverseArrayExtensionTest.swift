//
//  UniverseArrayExtensionTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseArrayExtensionTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testDescriptionList() {
        
        let inputList: [UniverseRoverCamera] = UniverseRoverCamera.completeList
        
        //Under test
        let resultList = inputList.descriptionList()
        XCTAssertFalse(resultList.isEmpty)
        XCTAssertTrue(resultList.count == 9)
        XCTAssertTrue(resultList.first! == "Front Hazard Avoidance Camera")
        XCTAssertTrue(resultList.last! == "Miniature Thermal Emission Spectrometer (Mini-TES)")
    }
    
    func testFetchingOfImageViewModelsWithoutImage() {
        
        let universeRoverPhotoDataList = UniverseImagerySampleJSONReader.roverImageryAPIResult()?.photos
        XCTAssertFalse(universeRoverPhotoDataList!.isEmpty)
        
        let vmOne = UniverseImageViewModel(withImageData: universeRoverPhotoDataList!.first!)
        let vmTwo = UniverseImageViewModel(withImageData: universeRoverPhotoDataList![2])
        
        //Under test
        var resutList = [vmOne, vmTwo].imageViewModelsWithoutImage()
        XCTAssertTrue(resutList.count == 2)
        
        vmTwo.updateImage(with: UIImage())
        XCTAssertNotNil(vmTwo.image)
        
        //Under test
        resutList = [vmOne, vmTwo].imageViewModelsWithoutImage()
        XCTAssertTrue(resutList.count == 1)
    }
}
