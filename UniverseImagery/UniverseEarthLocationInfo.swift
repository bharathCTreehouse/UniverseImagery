//
//  UniverseEarthLocationInfo.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 21/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import MapKit

//Local search results are converted into 'UniverseEarthLocationInfo' objects.
struct UniverseEarthLocationInfo {
    
    let locationName: String?
    let locationPlacemark: CLPlacemark
}
