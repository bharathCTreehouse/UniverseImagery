//
//  UniverseEarthLocationInfoViewModel.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 21/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit


class UniverseEarthLocationInfoViewModel {
    
    private(set) var locationInfo: UniverseEarthLocationInfo
    
    init(withLocationInfo info: UniverseEarthLocationInfo) {
        locationInfo = info
    }
    
    
    lazy var locationNameDisplayableDetail: (text: String, font: UIFont, color: UIColor) = {
        
        //Formatted location name
        
        return (text: locationInfo.locationName ?? "", font: UIFont.boldSystemFont(ofSize: 20.0), color: UIColor.white)
    }()
    
    
    lazy var addressDisplayableDetail: (text: String, font: UIFont, color: UIColor) = {
        
        //Formatted address
        
        var addressString: String = ""
        
        if let subFare = locationInfo.locationPlacemark.subThoroughfare {
            addressString = addressString + "\(subFare), "
        }
        if let thorFare = locationInfo.locationPlacemark.thoroughfare {
            addressString = addressString + "\(thorFare), "
        }
        if let subLocality = locationInfo.locationPlacemark.subLocality {
            addressString = addressString + "\(subLocality), "
        }
        if let locality = locationInfo.locationPlacemark.locality {
            addressString = addressString + "\(locality), "
        }
        if let administArea = locationInfo.locationPlacemark.administrativeArea {
            addressString = addressString + "\(administArea), "
        }
        if let country = locationInfo.locationPlacemark.country {
            addressString = addressString + "\(country), "
        }
        if let postalCode = locationInfo.locationPlacemark.postalCode {
            addressString = addressString + " Postal code: \(postalCode), "
        }
        addressString = String(addressString.dropLast(2))
        
        return (text: addressString, font: UIFont.boldSystemFont(ofSize: 18.0), color: UIColor.yellow)
    }()
    
}
