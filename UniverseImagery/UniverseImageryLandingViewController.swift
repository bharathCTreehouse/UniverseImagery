//
//  UniverseImageryLandingViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseImageryLandingViewController: UIViewController {
    
    @IBOutlet private(set) var marsImagesButton: UIButton!
    @IBOutlet private(set) var earthImagesButton: UIButton!


    @IBAction func marsImageButtonTapped(_ sender: UIButton) {
        let roverCriteriaSelectionController: UniverseRoverCriteriaSelectionViewController = UniverseRoverCriteriaSelectionViewController()
        navigationController?.pushViewController(roverCriteriaSelectionController, animated: true)
    }
    
    
    @IBAction func earthImageButtonTapped(_ sender: UIButton) {
        let earthCriteriaSelectionController: UniverseEarthCriteriaSelectionViewController = UniverseEarthCriteriaSelectionViewController()
        navigationController?.pushViewController(earthCriteriaSelectionController, animated: true)
    }
    
    
    deinit {
        marsImagesButton = nil
        earthImagesButton = nil
    }
}

