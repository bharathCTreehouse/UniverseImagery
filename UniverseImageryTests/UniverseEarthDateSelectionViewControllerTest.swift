//
//  UniverseEarthDateSelectionViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseEarthDateSelectionViewControllerTest: XCTestCase {
    
    var vc: UniverseEarthDateSelectionViewController! = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = UniverseEarthDateSelectionViewController(withLocationCoordinate: .init(latitude: 1.0, longitude: 5.0), addressString: "India")
        let _ = vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitializer() {
        
        XCTAssertTrue(vc.addressLabel.text == "India")
        XCTAssertTrue(vc.locationCoordinate.latitude == 1.0)
        XCTAssertTrue(vc.locationCoordinate.longitude == 5.0)
    }
    
    
    func testConfigurationOfDateTextFieldDelegate() {
        
        XCTAssertNotNil(vc.dateTextFieldDelegate)
        XCTAssertNil(vc.dateTextField.inputView)
        XCTAssertNil(vc.dateTextField.inputAccessoryView)

        //Under test
        vc.dateTextFieldDelegate?.stateHandler(.editingShouldBegin(forTxtField: vc.dateTextField))
        
        XCTAssertNotNil(vc.dateTextField.inputView)
        XCTAssertTrue(vc.dateTextField.inputView!.isMember(of: UniverseImageryDatePicker.self))
        XCTAssertNotNil(vc.dateTextField.inputAccessoryView)
        XCTAssertTrue(vc.dateTextField.inputAccessoryView!.isMember(of: UIToolbar.self))

    }
    
    func testCancellationOfImageFetchingTasks() {
        
        //Under test
        vc.viewWillDisappear(false)
        XCTAssertNil(vc.imageDataTask)
        XCTAssertNil(vc.imageFetchingQueue)
        
    }
    
    
    func testClearButtonTapped() {
        
        //Under test
        vc.clearButtonTapped(UIBarButtonItem())
        XCTAssertNil(vc.selectedDate)
    }
    
    
    
    func testDoneButtonTapped() {
        
        vc.dateTextFieldDelegate?.stateHandler(.editingShouldBegin(forTxtField: vc.dateTextField))
        vc.doneButtonTapped(UIBarButtonItem())
        XCTAssertNotNil(vc.selectedDate)
        XCTAssertNotNil(vc.dateTextField.text)
    }
    
    
    func testDateStringForEndpoint() {
        
        vc.dateTextFieldDelegate?.stateHandler(.editingShouldBegin(forTxtField: vc.dateTextField))
        vc.doneButtonTapped(UIBarButtonItem())
        XCTAssertNotNil(vc.selectedDate)
        
        //Under test
        XCTAssertNotNil(vc.dateStringForEndpoint())
    }
}
