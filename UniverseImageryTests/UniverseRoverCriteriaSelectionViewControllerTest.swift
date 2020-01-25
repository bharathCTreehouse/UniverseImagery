//
//  UniverseRoverCriteriaSelectionViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseRoverCriteriaSelectionViewControllerTest: XCTestCase {
    
    var vc: UniverseRoverCriteriaSelectionViewController! = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        vc = UniverseRoverCriteriaSelectionViewController()
        let _ = vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        vc = nil
    }
    
    
    func testCreationAndConfiguration() {
        
        XCTAssertNotNil(vc)
        
        //Under test
        XCTAssertNotNil(vc.roverSelectionCriteriaTextFieldDelegate)
        XCTAssertNotNil(vc.filterCriteriaTextField)
        XCTAssertNotNil(vc.filterCriteriaTextField.inputAccessoryView as? UIToolbar)
        
        //on viewWillAppear
        vc.viewWillAppear(false)
        XCTAssertTrue(vc.pageCount == 1)
        XCTAssertNil(vc.roversImageryDataTask)
        
    }
    
    
    func testConfigurationOfInputViewOnTextField() {
        
        //Under test
        vc.filterCriteriaSegmentControl.selectedSegmentIndex = 1
        vc.filterCriteriaSegmentControlTapped(vc.filterCriteriaSegmentControl)
        XCTAssertNotNil(vc.filterCriteriaTextField.inputView as? UniverseImageryDatePicker)
        XCTAssertTrue(vc.filterCriteriaTextField.placeholder == "Enter Date")
        XCTAssertNotNil(vc.filterCriteria)
        
        //Reset
        vc.filterCriteriaTextField.text = nil
        let datePicker: UniverseImageryDatePicker = vc.filterCriteriaDatePicker!
        datePicker.setDate(Date(), animated: false)
        vc.roverSelectionCriteriaTextFieldDelegate?.textFieldDidEndEditing(vc.filterCriteriaTextField)
        XCTAssertNotNil(vc.filterCriteriaTextField.text)
        XCTAssertNotNil(vc.filterCriteria)

        //Under test
        vc.filterCriteriaSegmentControl.selectedSegmentIndex = 0
        vc.filterCriteriaSegmentControlTapped(vc.filterCriteriaSegmentControl)
        XCTAssertNil(vc.filterCriteriaTextField.inputView)
        XCTAssertNil(vc.filterCriteriaDatePicker)
        XCTAssertTrue(vc.filterCriteriaTextField.placeholder == "Enter SOL")
        XCTAssertNotNil(vc.filterCriteria)
    }
    
    
    func testFilterCriteriaActivationSwitchToggled() {
        
        //under test -- when switch is ON
        vc.filterCriteriaActivationSwitch.setOn(true, animated: false)
        vc.filterCriteriaActivationSwitchToggled(vc.filterCriteriaActivationSwitch)
        XCTAssertTrue(vc.filterCriteriaTextField.alpha == 1.0)
        XCTAssertTrue(vc.filterCriteriaTextField.isUserInteractionEnabled)
        
        //under test -- when switch is OFF
        vc.filterCriteriaActivationSwitch.setOn(false, animated: false)
        vc.filterCriteriaActivationSwitchToggled(vc.filterCriteriaActivationSwitch)
        XCTAssertTrue(vc.filterCriteriaTextField.alpha != 1.0)
        XCTAssertFalse(vc.filterCriteriaTextField.isUserInteractionEnabled)
    }
}
