//
//  UniverseRoverImageCollectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 06/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseRoverImageCollectionViewController: UIViewController {
    
    @IBOutlet var selectCameraButton: UIButton!
    
   
    
    
    init() {
        super.init(nibName: "UniverseRoverImageCollectionViewController", bundle: .main)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "MARS IMAGE CRITERIA"
    }
    
    
    @IBAction func selectCameraButtonTapped(_ sender: UIButton) {
        
        let cameraSelectionVC: UniverseRoverCameraSelectionViewController = UniverseRoverCameraSelectionViewController(withSelectionHandler: { (camera: String) -> Void in
            
            print(camera)
            self.view.alpha = 1.0
        })
        let navController: UINavigationController = UINavigationController(rootViewController: cameraSelectionVC)
        present(navController, animated: true, completion: nil)
        view.alpha = 0.3
    }
    
    
    
    @IBAction func showResultsButtonTapped(_ sender: UIButton) {
        
    }


   

}
