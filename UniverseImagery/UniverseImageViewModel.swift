//
//  UniverseImageViewModel.swift
//  UniverseImagery
//
//  Created by Bharath on 14/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit


class UniverseImageViewModel {
    
    let imageData: UniverseImageryData
    private(set) var image: UIImage? = nil
    
    init(withImageData imageData: UniverseImageryData) {
        self.imageData = imageData
    }
    
    func updateImage(with image: UIImage?) {
        self.image = image
    }
}
