//
//  UniverseImageryRoverData.swift
//  UniverseImagery
//
//  Created by Bharath on 05/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


class UniverseImageryRoverData: UniverseImageryData {
    
    let earthDate: String
    let id: Int

    enum UniverseImageryRoverDataCodingKey: String, CodingKey {
        case earthDate = "earth_date"
        case url = "img_src"
        case id
    }
    
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: UniverseImageryRoverDataCodingKey.self)
        earthDate = try container.decode(String.self, forKey: .earthDate)
        id = try container.decode(Int.self, forKey: .id)
        try super.init(from: decoder)
    }
    
    
    override func urlString(usingDecoder decoder: Decoder) -> String {
        
        let container: KeyedDecodingContainer = try! decoder.container(keyedBy: UniverseImageryRoverDataCodingKey.self)
        let str: String = try! container.decode(String.self, forKey: .url)
        return str
    }
    
}
