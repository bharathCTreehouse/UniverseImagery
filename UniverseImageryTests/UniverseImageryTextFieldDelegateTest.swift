//
//  UniverseImageryTextFieldDelegateTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseImageryTextFieldDelegateTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testInvokingOfAppropriateDelegateMethod() {
        
        let textField: UITextField = UITextField()
        
        let textFieldDelegate: UniverseImageryTextFieldDelegate = UniverseImageryTextFieldDelegate(withTextField: textField, stateHandler: { (state: UniverseImageryTextFieldDelegateState) -> Void in
            
            switch state {
                case .editingDidBegin(forTxtField: let textField): XCTAssertTrue(textField.text == "India")
                case .returnKeyTapped(forTxtField: let textField):
                    XCTAssertTrue(textField.text == "Blr")
                case .editingDidEnd(forTxtField: let textField):
                    XCTAssertTrue(textField.text == "YoYo")
                case .editingShouldBegin(forTxtField: let textField):
                    XCTAssertTrue(textField.text == "SahanaBC")
            }
            
        })
        
        //Invoke
        textField.text = "India"
        textFieldDelegate.textFieldDidBeginEditing(textField)
        
        //Invoke
        textField.text = "Blr"
        let _ = textFieldDelegate.textFieldShouldReturn(textField)
        
        //Invoke
        textField.text = "YoYo"
        let _ = textFieldDelegate.textFieldDidEndEditing(textField)
        
        //Invoke
        textField.text = "SahanaBC"
        let _ = textFieldDelegate.textFieldShouldBeginEditing(textField)
        
    }
}
