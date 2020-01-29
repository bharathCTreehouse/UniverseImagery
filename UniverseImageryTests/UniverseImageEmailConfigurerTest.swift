//
//  UniverseImageEmailConfigurerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
import MessageUI

@testable import UniverseImagery


class UniverseImageEmailConfigurerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmailConfiguration() {
        
        let _ = UniverseImageEmailConfigurer(withEmailDataSource: self, configurationCompletionHandler: { (composeVC: MFMailComposeViewController?) -> Void in
            
            XCTAssertNil(composeVC)
            
        }, compositionCompletionHandler: { (state: UniverseImageEmailComposeState, composeVC: MFMailComposeViewController) -> Void in
            
        })
    }
}


extension UniverseImageEmailConfigurerTest: UniverseImageEmailDataSource {
    
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
