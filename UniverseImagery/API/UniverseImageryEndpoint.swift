//
//  UniverseImageryEndpoint.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


enum UniverseImageryEndpoint: UniverseImageryUrlCreator {
    
    case fetchRoverImage(page: Int?, fetchCriteria: UniverseRoverCameraCriteria, cameraType: UniverseRoverCamera?)
    case fetchEarthImage
    case unknown
    
    var urlPath: String {
        
        switch self {
            case .fetchRoverImage: return "/mars-photos/api/v1/rovers/curiosity/photos"
            case .fetchEarthImage: return ""
            default: return ""
        }
    }
       
    var urlQueryItems: [URLQueryItem] {
        
        var allQueryItems: [URLQueryItem] = []
        let apiKeyQueryItem: URLQueryItem = URLQueryItem(name: "api_key", value:  "Nb9iAdmHysgBLEWAYeGWNxs6nJq3mHVy4MgDrijF")
        allQueryItems.append(apiKeyQueryItem)
        
        switch self {
            
            case .fetchRoverImage(page: let pageValue, fetchCriteria: let criteria, cameraType: let camType):
                
                if pageValue != nil {
                    //Page value entered
                    let pageQItem = URLQueryItem(name: "page", value: "\(pageValue!)")
                    allQueryItems.append(pageQItem)
                }
                //Fetch based on sol or earth date
                switch criteria {
                    case .sol(let solValue):
                        let solQItem = URLQueryItem(name: "sol", value: "\(solValue)")
                        allQueryItems.append(solQItem)
                    case .earthDate(let dateStringValue):
                        let earthDateQItem = URLQueryItem(name: "earth_date", value: dateStringValue)
                        allQueryItems.append(earthDateQItem)
                }
                //Include camera type
                if camType != nil {
                    let cameraQItem = URLQueryItem(name: "camera", value: camType!.rawValue)
                    allQueryItems.append(cameraQItem)
                }
                
            case .fetchEarthImage: print("")
            
            default: print("")
        }
        
        return allQueryItems
    }
}
