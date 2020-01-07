//
//  UniverseRoverCamera.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


enum UniverseRoverCamera: String, CustomStringConvertible {
    
    case FHAZ = "fhaz"
    case RHAZ = "rhaz"
    case MAST = "mast"
    case CHEMCAM = "chemcam"
    case MAHLI = "mahli"
    case MARDI = "mardi"
    case NAVCAM = "navcam"
    case PANCAM = "pancam"
    case MINITES = "minites"
    
    var description: String {
        switch self {
            case .FHAZ: return "Front Hazard Avoidance Camera"
            case .RHAZ: return "Rear Hazard Avoidance Camera"
            case .MAST: return "Mast Camera"
            case .CHEMCAM: return "Chemistry and Camera Complex"
            case .MAHLI: return "Mars Hand Lens Imager"
            case .MARDI: return "Mars Descent Imager"
            case .NAVCAM: return "Navigation Camera"
            case .PANCAM: return "Panoramic Camera"
            case .MINITES: return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }
    
    static var completeList: [UniverseRoverCamera] {
        return [.FHAZ, .RHAZ, .MAST, .CHEMCAM, .MAHLI, .MARDI, .NAVCAM, .PANCAM, .MINITES]
    }
}
