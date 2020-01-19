//
//  ViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var marsImagesButton: UIButton!
    @IBOutlet private var earthImagesButton: UIButton!


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    
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

