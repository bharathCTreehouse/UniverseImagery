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
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!

    let locationCoordinate: CLLocationCoordinate2D
    let locationAddressString: String
    private(set) var dateTextFieldDelegate: UniverseImageryTextFieldDelegate? = nil
    var selectedDate: Date? = nil
    var imageFetchingQueue: OperationQueue? = nil
    private var fetchInProgress: Bool = false {
        didSet {
            if fetchInProgress == true {
                self.activityIndicatorView.startAnimating()
                self.showImageButton.enable(false, withAlpha: 0.3)
            }
            else {
                self.activityIndicatorView.stopAnimating()
                self.showImageButton.enable(true)
            }
        }
    }

    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicatorView.addObserver(self, forKeyPath: "isAnimating", options: .new, context: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageFetchingQueue?.cancelAllOperations()
        imageFetchingQueue = nil
        self.activityIndicatorView.removeObserver(self, forKeyPath: "isAnimating")
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "isAnimating" {
            print("Bingo")
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    
    @objc func clearButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        dateTextField.text = nil
        selectedDate = nil
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
        
        fetchInProgress = true
        
        let api: UniverseImageAPI = UniverseImageAPI()
        api.fetchEarthImagery(forEndpoint: earthImageEndpoint, withCompletionHandler: { [unowned self] (earthData: UniverseImageryEarthData?, err: Error?) -> Void in
            
            DispatchQueue.main.async {
                
                if let earthData = earthData {
                    self.fetchImage(forEarthData: earthData)
                }
                else {
                    
                    self.fetchInProgress = false
                    
                    var errorTitle: String = ""
                    if err != nil {
                        errorTitle = err!.localizedDescription
                    }
                    else {
                        //No image found
                        errorTitle = "There is no image matching your search criteria. Please refine your criteria and try again"
                    }
                    self.showAlert(withTitle: errorTitle, alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
                }
            }
            
        })
    }
    
    
    
    func fetchImage(forEarthData earthData: UniverseImageryEarthData) {
        
        let imageUrl: URL? = URL(string: earthData.url)
        
        guard let _ = imageUrl else {
            
            fetchInProgress = false
            self.showAlert(withTitle: "Failed to fetch image", alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
            return
        }
        
        imageFetchingQueue = OperationQueue()
        
        let imgOperation: UniverseImageOperation = UniverseImageOperation(withImageUrl: imageUrl!, completionHandler: { [unowned self] (image: UIImage?, id: String?, err: Error?, operationCancelled: Bool) -> Void in
            
            DispatchQueue.main.async {
                
                self.fetchInProgress = false

                guard operationCancelled == false else {
                    return
                }
                
                if err != nil {
                    self.showAlert(withTitle: err!.localizedDescription, alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
                }
                else if image != nil {
                    let imageViewController: UniverseImageViewController = UniverseImageViewController(withUniverseImage: image!)
                    let navController: UINavigationController = UINavigationController(rootViewController: imageViewController)
                    self.present(navController, animated: true, completion: nil)
                }
            }
        })
        
        imageFetchingQueue!.addOperation(imgOperation)
        
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
        activityIndicatorView = nil
    }

}
