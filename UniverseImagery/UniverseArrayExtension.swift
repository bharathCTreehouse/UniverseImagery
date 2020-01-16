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

extension Array where Element == UniverseImageViewModel {
    
    func imageViewModelsWithoutImage() -> [UniverseImageViewModel] {
        
        let filteredList: [UniverseImageViewModel] = self.filter({ (vm: UniverseImageViewModel) -> Bool in
            return vm.image == nil
        })
        
        return filteredList
    }
    
}
