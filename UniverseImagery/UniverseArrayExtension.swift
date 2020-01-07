//
//  UniverseArrayExtension.swift
//  UniverseImagery
//
//  Created by Bharath on 07/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


extension Array where Element: CustomStringConvertible {
    
    func descriptionList() -> [String] {
        
        let list: [String] = self.compactMap({ (input: CustomStringConvertible) -> String in
            return input.description
        })
        
        return list
    }
}
