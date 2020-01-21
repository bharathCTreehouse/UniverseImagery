//
//  UniverseEarthDateSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 21/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit
import CoreLocation


class UniverseEarthDateSelectionViewController: UIViewController {
    
    @IBOutlet weak private var dateTextField: UITextField!
    @IBOutlet weak private var addressLabel: UILabel!

    let locationCoordinate: CLLocationCoordinate2D
    let locationAddressString: String
    
    lazy var dateTextFieldDelegate: UniverseImageryTextFieldDelegate = {
        
        return UniverseImageryTextFieldDelegate(withTextField: dateTextField, stateHandler: { (state: UniverseImageryTextFieldDelegateState) -> Void in
            
            
        })
    }()
    
    
    required init(withLocationCoordinate coordinate: CLLocationCoordinate2D, addressString addr: String) {
        
        locationCoordinate = coordinate
        locationAddressString = addr
        super.init(nibName: "UniverseEarthDateSelectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressLabel.text = locationAddressString
    }


    

}
