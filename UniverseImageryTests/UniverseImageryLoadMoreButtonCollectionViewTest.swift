//
//  UniverseImageryLoadMoreButtonCollectionViewTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery

class UniverseImageryLoadMoreButtonCollectionViewTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testConfiguration() {
        
        let view: UniverseImageryLoadMoreButtonCollectionView =  UniverseImageryLoadMoreButtonCollectionView(frame: .zero)
        XCTAssertNotNil(view.activityIndicatorView)
        XCTAssertNotNil(view.loadMoreButton)
        XCTAssertTrue(view.loadMoreButton.title(for: .normal) == "LOAD MORE")
        XCTAssertTrue(view.backgroundColor == UIColor.lightText)
        XCTAssertTrue(view.loadMoreButton.isEnabled)
        XCTAssertFalse(view.activityIndicatorView.isAnimating)
        
        //Change state and test
        view.changeCurrentState(to: .inProgress)
        XCTAssertFalse(view.loadMoreButton.isEnabled)
        XCTAssertTrue(view.activityIndicatorView.isAnimating)
        
    }
}
