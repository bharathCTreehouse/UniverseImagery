//
//  UniverseRoverAPIResult.swift
//  UniverseImagery
//
//  Created by Bharath on 05/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


class UniverseRoverAPIResult: Decodable {
    
    let photos: [UniverseImageryRoverData]
    
    enum UniverseRoverAPIResultCodingKey: String, CodingKey {
        case photos
    }
    
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: UniverseRoverAPIResultCodingKey.self)
        photos = try container.decode([UniverseImageryRoverData].self, forKey: .photos)
    }
    
}
