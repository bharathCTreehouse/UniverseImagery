//
//  UniverseImageryErrorUtilities.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 19/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


extension Error {
    
    var causedByAPICancellation: Bool {
        
        let apiError: NSError = (self as NSError)
        return apiError.code == NSUserCancelledError || apiError.code == NSURLErrorCancelled
    }
    
}
