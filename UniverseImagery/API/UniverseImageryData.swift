//
//  UniverseImageryData.swift
//  UniverseImagery
//
//  Created by Bharath on 05/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


class UniverseImageryData: Decodable {
    
    let id: Int
    var url: String = ""
    
    enum UniverseImageryDataCodingKey: String, CodingKey {
        case id
        case url
    }
    
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: UniverseImageryDataCodingKey.self)
        id = try container.decode(Int.self, forKey: .id)
        url = urlString(usingDecoder: decoder)
    }
    
    
    func urlString(usingDecoder decoder: Decoder) -> String {
        
        let container: KeyedDecodingContainer = try! decoder.container(keyedBy: UniverseImageryDataCodingKey.self)
        let str: String = try! container.decode(String.self, forKey: .url)
        return str
    }
}
