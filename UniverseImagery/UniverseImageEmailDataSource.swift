//
//  UniverseImageEmailDataSource.swift
//  UniverseImagery
//
//  Created by Bharath on 15/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation


protocol UniverseImageEmailDataSource {
    
    var toAddresses: [String] { get }
    var ccAddresses: [String] { get }
    var bccAddresses: [String] { get }
    var emailSubject: String { get }
    var emailBodyDetail: (text: String, html: Bool) { get }
    var emailAttachments: [(data: Data, mime: String, fileName: String)] { get }
}

extension UniverseImageEmailDataSource {
    
    var toAddresses: [String] {
        return []
    }
    var ccAddresses: [String] {
        return []
    }
    var bccAddresses: [String] {
        return []
    }
    var emailSubject: String {
        return "Universe Imagery"
    }
    var emailBodyDetail: (text: String, html: Bool) {
        return (text: "", html: true)
    }
    var emailAttachments: [(data: Data, mime: String, fileName: String)] {
        return []
    }
}
