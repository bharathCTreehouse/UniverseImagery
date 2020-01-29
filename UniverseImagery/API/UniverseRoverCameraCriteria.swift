//
//  UniverseRoverCameraCriteria.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation

enum UniverseRoverCameraCriteriaValidationError: Error {
    case criteriaMissing
    case invalidValue(String)
}


enum UniverseRoverCameraCriteria {
    case sol(UInt)
    case earthDate(String)   //date format is YYYY-MM-DD
    
    static var earthDateFormat: String {
        return "yyyy-MM-dd"
    }
}
