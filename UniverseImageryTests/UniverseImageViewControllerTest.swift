//
//  UniverseImageViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseImageViewControllerTest: XCTestCase {
    
    var vc: UniverseImageViewController! = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = UniverseImageViewController(withUniverseImage: UIImage())
        let _ = vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vc = nil
    }
    
    
    func testInitialUI() {
        XCTAssertNotNil(vc.universeImage)
        XCTAssertNotNil(vc.universeImageView.image)
    }
    
    
    func testEmailDataSource() {
        XCTAssertTrue(vc.toAddresses.isEmpty)
        XCTAssertTrue(vc.ccAddresses.isEmpty)
        XCTAssertTrue(vc.bccAddresses.isEmpty)
        XCTAssertTrue(vc.emailSubject == "Post card from Universe Imagery")
        XCTAssertTrue(vc.emailBodyDetail.text == "Greetings.  Enjoy the card dude.")
    }
}
