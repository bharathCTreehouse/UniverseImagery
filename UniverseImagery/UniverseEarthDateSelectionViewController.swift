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
    @IBOutlet weak private var showImageButton: UIButton!
    let locationCoordinate: CLLocationCoordinate2D
    let locationAddressString: String
    private(set) var dateTextFieldDelegate: UniverseImageryTextFieldDelegate? = nil
    var selectedDate: Date? = nil
    
    
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
        
        dateTextFieldDelegate = UniverseImageryTextFieldDelegate(withTextField: dateTextField, stateHandler: { (state: UniverseImageryTextFieldDelegateState) -> Void in
            
            switch state {
                
                case .editingShouldBegin:
                    
                    if self.dateTextField.inputView == nil {
                        
                        //Setup date picker view.
                        let datePicker: UniverseImageryDatePicker = UniverseImageryDatePicker()
                        self.dateTextField.inputView = datePicker
                        
                        //Add tool bar with done and clear buttons.
                        let toolBar: UIToolbar = UIToolbar(frame: .init(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 44.0))
                        let clearButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.clearButtonTapped(_:)))
                        let flexiSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonTapped(_:)))
                        toolBar.setItems([clearButton, flexiSpace, doneButton ], animated: false)
                        self.dateTextField.inputAccessoryView = toolBar

                    }
                
                default: break
            }
            
        })

    }
    
    
    @objc func clearButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        dateTextField.text = nil
    }
    
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        view.endEditing(true)
        
        let datePicker: UniverseImageryDatePicker? = dateTextField.inputView as? UniverseImageryDatePicker
        
        if datePicker != nil {
            
            selectedDate = datePicker!.date
            let df: DateFormatter = DateFormatter()
            df.dateStyle = .medium
            df.timeZone = .none
            
            dateTextField.text = df.string(from: selectedDate!)
        }
    }
    
    
    @IBAction func showImageButtonTapped(_ sender: UIButton) {
        
        let earthImageEndpoint: UniverseImageryEndpoint = .fetchEarthImage(latitude: Float(self.locationCoordinate.latitude), longitude: Float(self.locationCoordinate.longitude), date: dateStringForEndpoint())
        
        let api: UniverseImageAPI = UniverseImageAPI()
        api.fetchEarthImagery(forEndpoint: earthImageEndpoint, withCompletionHandler: { (earthData: UniverseImageryEarthData?, err: Error?) -> Void in
            
            if err != nil {
                print(err!.localizedDescription)
            }
            else if let earthData = earthData{
                print(earthData)
            }
        })
    }
    
    
    func dateStringForEndpoint() -> String? {
        
        if selectedDate != nil {
            let df: DateFormatter = DateFormatter()
            df.dateFormat = "YYYY-MM-DD"
            return df.string(from: selectedDate!)
        }
        else {
            return nil
        }
    }
    
    
    deinit {
        selectedDate = nil
        dateTextField = nil
        addressLabel = nil
        showImageButton = nil
        dateTextFieldDelegate = nil
    }

}
