//
//  UniverseImageCollectionViewControllerTest.swift
//  UniverseImageryTests
//
//  Created by Bharath on 29/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import XCTest
@testable import UniverseImagery


class UniverseImageCollectionViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testInitializer() {
        
        let roverPhotoList: [UniverseImageryRoverData] = UniverseImagerySampleJSONReader.roverImageryAPIResult()!.photos
        
        let vmOne = UniverseImageViewModel(withImageData: roverPhotoList.first!)
        let vmTwo = UniverseImageViewModel(withImageData: roverPhotoList.last!)
        
        let vc = UniverseImageCollectionViewController(withImageViewModels: [vmOne, vmTwo], loadMoreTapHandler: { () -> Void in
            
        })
        let _ = vc.view
        XCTAssertTrue(vc.imageViewModels.count == 2)
        
        //test viewDidAppear
        vc.viewDidAppear(false)
        XCTAssertTrue(vc.imageViewModels.count == 2)
        
        //test viewWillDisappear
        vc.viewWillDisappear(false)
        XCTAssertNil(vc.imageDownloadingQueue)
        
        //test collection view data source and delegates
        XCTAssertTrue(vc.collectionView(vc.collectionView, numberOfItemsInSection: 0) == 2)
        XCTAssertTrue(vc.numberOfSections(in: vc.collectionView) == 1)
        XCTAssertNotNil(vc.collectionView(vc.collectionView, cellForItemAt: IndexPath.init(row: 0, section: 0)).contentView.viewWithTag(10))
        
        //test supplementary view
        let collectionReusableView: UICollectionReusableView = vc.collectionView(vc.collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(row: 1, section: 0))
        XCTAssertTrue(collectionReusableView.isKind(of: UniverseImageryLoadMoreButtonCollectionView.self))
        XCTAssertTrue(((collectionReusableView as! UniverseImageryLoadMoreButtonCollectionView).viewDelegate != nil))
    }
}
