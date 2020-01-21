//
//  UniverseImageryEarthData.swift
//  UniverseImagery
//
//  Created by Bharath on 06/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


class UniverseImageryEarthData: UniverseImageryData {
    
    let cloudScore: Double = 0.0
    let id: String

    enum UniverseImageryRoverDataCodingKey: String, CodingKey {
        case id
    }
    
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: UniverseImageryRoverDataCodingKey.self)
        id = try container.decode(String.self, forKey: .id)
        try super.init(from: decoder)
    }
}
