//
//  UniverseImageryTextFieldDelegate.swift
//  UniverseImagery
//
//  Created by Bharath on 12/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit

enum UniverseImageryTextFieldDelegateState {
    case editingDidBegin(forTxtField: UITextField)
    case returnKeyTapped(forTxtField: UITextField)
    case editingDidEnd(forTxtField: UITextField)
}


class UniverseImageryTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let stateHandler: ((UniverseImageryTextFieldDelegateState) -> Void)
    private let textField: UITextField
    
    
    init(withTextField textField: UITextField, stateHandler handler: @escaping ((UniverseImageryTextFieldDelegateState) -> Void)) {
        
        stateHandler = handler
        self.textField = textField
        super.init()
        self.textField.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        stateHandler(.editingDidBegin(forTxtField: textField))
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        stateHandler(.returnKeyTapped(forTxtField: textField))
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        stateHandler(.editingDidEnd(forTxtField: textField))
    }
    
    
    deinit {
        print("UniverseImageryTextFieldDelegate")
    }
}
