//
//  UniverseImageryData.swift
//  UniverseImagery
//
//  Created by Bharath on 05/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


class UniverseImageryData: Decodable {
    
    var url: String = ""
    
    enum UniverseImageryDataCodingKey: String, CodingKey {
        case url
    }
    
    
    required init(from decoder: Decoder) throws {
        url = urlString(usingDecoder: decoder)
    }
    
    
    func urlString(usingDecoder decoder: Decoder) -> String {
        
        let container: KeyedDecodingContainer = try! decoder.container(keyedBy: UniverseImageryDataCodingKey.self)
        let str: String = try! container.decode(String.self, forKey: .url)
        return str
    }
}
