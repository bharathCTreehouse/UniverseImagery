//
//  UniverseImageryUrlCreator.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


protocol UniverseImageryUrlCreator {
    
    var urlBase: String { get }
    var urlPath: String { get }
    var urlQueryItems: [URLQueryItem] { get }
}


extension UniverseImageryUrlCreator {
    
    var urlBase: String {
        return "https://api.nasa.gov/"
    }
    
    
    var urlRequest: URLRequest? {
        
        var urlComp: URLComponents? = URLComponents(string: urlBase)
        urlComp?.queryItems = urlQueryItems
        urlComp?.path = urlPath
        if let url = urlComp?.url {
            return URLRequest(url: url)
        }
        else {
            return nil
        }
    }
}
