//
//  UniverseImagerySampleJSONReader.swift
//  UniverseImageryTests
//
//  Created by Bharath on 25/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
@testable import UniverseImagery


class UniverseImagerySampleJSONReader {
    
    static func roverImageryAPIResult() -> UniverseRoverAPIResult? {
        
        let jsonFilePath: String? = Bundle.init(for: UniverseRoverAPIResultTest.self).path(forResource: "UniverseImageryRoverAPISample", ofType: "json")
        
        guard let _ = jsonFilePath else {
            return nil
        }
        
        let pathURL: URL? = URL(fileURLWithPath: jsonFilePath!)
        
        do {
            let jsonData: Data = try Data(contentsOf: pathURL!)
            let jsonDecoder: JSONDecoder = JSONDecoder()
            let roverAPIResult: UniverseRoverAPIResult = try! jsonDecoder.decode(UniverseRoverAPIResult.self, from: jsonData)
            return roverAPIResult
            
        }
        catch {
            return nil
        }
        
    }
    
    
    static func earthImageryAPIResult() -> UniverseImageryEarthData? {
        
        let jsonFilePath: String? = Bundle.init(for: UniverseImageryEarthDataTest.self).path(forResource: "UniverseImageryEarthAPISample", ofType: "json")
        
        guard let _ = jsonFilePath else {
            return nil
        }
        
        let pathURL: URL? = URL(fileURLWithPath: jsonFilePath!)
        
        do {
            let jsonData: Data = try Data(contentsOf: pathURL!)
            let jsonDecoder: JSONDecoder = JSONDecoder()
            let earthAPIResult: UniverseImageryEarthData = try! jsonDecoder.decode(UniverseImageryEarthData.self, from: jsonData)
            return earthAPIResult
            
        }
        catch {
            return nil
        }
        
    }
    
}
