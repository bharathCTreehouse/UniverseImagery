//
//  UniverseRoverImageCollectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 06/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit


class UniverseRoverImageCollectionViewController: UIViewController {
    
    @IBOutlet private weak var selectCameraButton: UIButton!
    @IBOutlet private weak var filterCriteriaSegmentControl: UISegmentedControl!
    @IBOutlet private weak var filterCriteriaActivationSwitch: UISwitch!
    @IBOutlet private weak var filterCriteriaTextField: UITextField!
    
    private(set) var filterCriteria: UniverseRoverCameraCriteria? = nil
    private(set) var cameraType: UniverseRoverCamera? = nil
    private var filterCriteriaDatePicker: UniverseImageryDatePicker? = nil



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
    

    deinit {
        selectCameraButton = nil
        filterCriteriaSegmentControl = nil
        filterCriteriaActivationSwitch = nil
        filterCriteriaTextField = nil
        filterCriteriaDatePicker = nil
        cameraType = nil
        filterCriteria = nil
    }
    
}



extension UniverseRoverImageCollectionViewController {
    
    @IBAction func selectCameraButtonTapped(_ sender: UIButton) {
        
        let cameraSelectionVC: UniverseRoverCameraSelectionViewController = UniverseRoverCameraSelectionViewController(withSelectionHandler: { (camera: String) -> Void in
            
            print(camera)
            self.view.alpha = 1.0
        })
        let navController: UINavigationController = UINavigationController(rootViewController: cameraSelectionVC)
        present(navController, animated: true, completion: nil)
        view.alpha = 0.3
    }
    
    
    @IBAction func filterCriteriaActivationSwitchToggled(_ sender: UISwitch) {
        
        if sender.isOn == true {
            filterCriteriaTextField.alpha = 1.0
        }
        else {
            filterCriteriaTextField.alpha = 0.4
            filterCriteria = nil
        }
        filterCriteriaTextField.isUserInteractionEnabled = sender.isOn
    }
    
    
    @IBAction func filterCriteriaSegmentControlTapped(_ sender: UISegmentedControl) {
        
        filterCriteriaTextField.text = nil
        view.endEditing(true)
        
        if sender.selectedSegmentIndex == 0 {
            filterCriteriaTextField.placeholder = "Enter SOL"
            filterCriteria = .sol(0)
            filterCriteriaDatePicker = nil
            filterCriteriaTextField.inputView = nil
            filterCriteriaTextField.inputAccessoryView = nil
        }
        else {
            filterCriteriaDatePicker = UniverseImageryDatePicker()
            filterCriteriaTextField.placeholder = "Enter Date"
            filterCriteria = .earthDate("")
            filterCriteriaTextField.inputView = filterCriteriaDatePicker
            
            let keyboardToolbar = UIToolbar(frame: .init(x: 0.0, y: 0.0, width: view.frame.size.width, height: 50.0))
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeypad))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
            filterCriteriaTextField.inputAccessoryView = keyboardToolbar
        }
    }
    
    
    @objc func dismissKeypad() {
        
        let dateSelected: Date = filterCriteriaDatePicker!.date
        let df: DateFormatter = DateFormatter()
        df.dateStyle = .medium
        df.timeZone = .none
        filterCriteriaTextField.text = df.string(from: dateSelected)
        view.endEditing(true)
        
        //For the API.
        df.dateFormat = UniverseRoverCameraCriteria.earthDateFormat
        filterCriteria = .earthDate(df.string(from: dateSelected))
    }
    
    
    @IBAction func showResultsButtonTapped(_ sender: UIButton) {
        print("showResultsButtonTapped")
    }
}
