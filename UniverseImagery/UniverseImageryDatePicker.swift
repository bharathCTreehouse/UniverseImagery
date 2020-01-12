//
//  UniverseImageryDatePicker.swift
//  UniverseImagery
//
//  Created by Bharath on 13/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit


class UniverseImageryDatePicker: UIDatePicker {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.datePickerMode = .date
        self.setDate(Date(), animated: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

