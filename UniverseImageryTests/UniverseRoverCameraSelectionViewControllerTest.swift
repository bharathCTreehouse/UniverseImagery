//
//  UniverseRoverCameraSelectionViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 26/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseRoverCameraSelectionViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreationAndConfiguration() {
        
        let vc: UniverseRoverCameraSelectionViewController =  UniverseRoverCameraSelectionViewController { (_, _, _) in
        }
        XCTAssertNil(vc.cameraListTableView)
        
        let _ = vc.view
        XCTAssertNotNil(vc.cameraListTableView)
        XCTAssertTrue(vc.cameraListTableView.estimatedRowHeight == 60.0)
        XCTAssertTrue(vc.cameraListTableView.rowHeight == UITableView.automaticDimension)
        XCTAssertNotNil(vc.cameraListTableView.tableFooterView)
        XCTAssertNotNil(vc.cameraListTableView.dataSource)
        XCTAssertNotNil(vc.cameraListTableView.delegate)
        XCTAssertTrue(vc.cameraListTableView.numberOfRows(inSection: 0) == 9)
        
        var cell: UITableViewCell = vc.tableView(vc.cameraListTableView, cellForRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertTrue(cell.textLabel?.text == "Front Hazard Avoidance Camera")
        
        cell = vc.tableView(vc.cameraListTableView, cellForRowAt: IndexPath.init(row: 8, section: 0))
        XCTAssertTrue(cell.textLabel?.text == "Miniature Thermal Emission Spectrometer (Mini-TES)")
    }
}
