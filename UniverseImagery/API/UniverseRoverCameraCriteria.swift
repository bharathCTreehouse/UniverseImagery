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
    
    /*func validateSol() throws {
        
        switch self {
            case .sol(let value):
                if value < 0 || value > 1000 {
                    throw UniverseRoverCameraCriteriaValidationError.invalidValue("Invalid Sol value entered. Please enter a value between 0 and 1000.")
                }
            default: throw UniverseRoverCameraCriteriaValidationError.criteriaMissing
        }
    }
    
    func validateEarthDate() throws {
        
        switch self {
            case .earthDate(let value):
                if value.isEmpty == true {
                    throw UniverseRoverCameraCriteriaValidationError.invalidValue("Invalid earth date value entered. Please enter a valid date")
                }
            default: throw UniverseRoverCameraCriteriaValidationError.criteriaMissing
        }
    }*/
}
