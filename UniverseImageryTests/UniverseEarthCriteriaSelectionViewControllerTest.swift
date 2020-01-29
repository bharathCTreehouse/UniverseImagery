//
//  UniverseEarthCriteriaSelectionViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseEarthCriteriaSelectionViewControllerTest: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testLocationListTableView() {
        
        let vc: UniverseEarthCriteriaSelectionViewController = UniverseEarthCriteriaSelectionViewController()
        let _ = vc.view

        XCTAssertNotNil(vc.locationListTableView)
        XCTAssertNotNil(vc.locationSearchBar)
        
        vc.earthLocationViewModels = []
        XCTAssertTrue(vc.tableView(vc.locationListTableView, numberOfRowsInSection: 0) == 0)
    }
}
