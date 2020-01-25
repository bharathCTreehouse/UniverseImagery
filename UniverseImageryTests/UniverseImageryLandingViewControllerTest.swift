//
//  UniverseImageryLandingViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseImageryLandingViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testUniverseLandingViewControllerForMars() {
        
        let sb: UIStoryboard = UIStoryboard.init(name: "Main", bundle: .main)
        let landingVC: UniverseImageryLandingViewController = sb.instantiateViewController(identifier: "UniverseImageryLandingViewController")
        let navController: UINavigationController = UINavigationController(rootViewController: landingVC)
        XCTAssertNotNil(landingVC.navigationController)
        XCTAssertTrue(navController.viewControllers.count == 1)
        let _ = landingVC.view
        XCTAssertNotNil(landingVC.marsImagesButton)
        XCTAssertNotNil(landingVC.earthImagesButton)

        //Under test
        landingVC.marsImageButtonTapped(landingVC.marsImagesButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { () -> Void in
            XCTAssertTrue(navController.viewControllers.count == 2)
            XCTAssertTrue(navController.topViewController!.classForCoder ==  UniverseRoverCriteriaSelectionViewController.classForCoder() )
        })

    }
    
    
    func testUniverseLandingViewControllerForEarth() {
        
        let sb: UIStoryboard = UIStoryboard.init(name: "Main", bundle: .main)
        let landingVC: UniverseImageryLandingViewController = sb.instantiateViewController(identifier: "UniverseImageryLandingViewController")
        let navController: UINavigationController = UINavigationController(rootViewController: landingVC)
        XCTAssertNotNil(landingVC.navigationController)
        XCTAssertTrue(navController.viewControllers.count == 1)
        let _ = landingVC.view
        XCTAssertNotNil(landingVC.marsImagesButton)
        XCTAssertNotNil(landingVC.earthImagesButton)

        //Under test
        landingVC.earthImageButtonTapped(landingVC.earthImagesButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { () -> Void in
            XCTAssertTrue(navController.viewControllers.count == 2)
            XCTAssertTrue(navController.topViewController!.classForCoder ==  UniverseEarthCriteriaSelectionViewController.classForCoder() )

        })

    }
}
