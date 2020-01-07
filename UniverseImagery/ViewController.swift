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
        
        /*let apiClient: UniverseImageAPI = UniverseImageAPI()

        let roverEndPoint: UniverseImageryEndpoint = .fetchRoverImage(page: nil, fetchCriteria: .sol(0), cameraType: .CHEMCAM)
        apiClient.fetchMarsRoverImagery(forEndpoint: roverEndPoint, withCompletionHandler: { (roverDataList: [UniverseImageryRoverData]?, error: Error?) -> Void in
            
            if let error = error {
                print("\(error)")
            }
            else {
                if let roverDataList = roverDataList {
                    for roverData in roverDataList {
                        print("\(roverData.id), \(roverData.url)")
                    }
                }
            }
        })*/
    }
    
    
    @IBAction func marsImageButtonTapped(_ sender: UIButton) {
        let roverImageController: UniverseRoverImageCollectionViewController = UniverseRoverImageCollectionViewController()
        self.navigationController?.pushViewController(roverImageController, animated: true)
    }
    
    
    deinit {
        marsImagesButton = nil
        earthImagesButton = nil
    }
    
    
  
}

