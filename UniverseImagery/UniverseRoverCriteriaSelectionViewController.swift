//
//  UniverseRoverCriteriaSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 06/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit


enum UniverseRoverFilter: Int {
    case sol
    case earthDate
}


class UniverseRoverCriteriaSelectionViewController: UIViewController {
    
    @IBOutlet private(set) weak var selectCameraButton: UIButton!
    @IBOutlet private(set) weak var filterCriteriaSegmentControl: UISegmentedControl!
    @IBOutlet private(set) weak var filterCriteriaActivationSwitch: UISwitch!
    @IBOutlet private(set) weak var filterCriteriaTextField: UITextField!
    @IBOutlet private(set) weak var cameraTypeLabel: UILabel!
    @IBOutlet private(set) weak var searchResultsIndicatorView: UIActivityIndicatorView!
    @IBOutlet private(set) weak var showResultsButton : UIButton!


    //criteria to search/filter (to be used for the API)
    private(set) var filterCriteria: UniverseRoverCameraCriteria? = nil
    private(set) var cameraType: UniverseRoverCamera? = nil
    
    private(set) var filterCriteriaDatePicker: UniverseImageryDatePicker? = nil
    private(set) var roverSelectionCriteriaTextFieldDelegate: UniverseImageryTextFieldDelegate? = nil
    
    var pageCount: Int = 1
    private(set) var roversImageryDataTask: URLSessionDataTask? = nil
    
    lazy var dateFormatterForDisplay: DateFormatter = {
       
        let df: DateFormatter = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()



    init() {
        super.init(nibName: "UniverseRoverCriteriaSelectionViewController", bundle: .main)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "MARS IMAGE CRITERIA"
        
        //setup the textfield delegate.
        configureRoverSelectionCriteriaTextFieldDelegate()
        
        //Add a done button on top of keypad that'll be used to dismiss it.
        addDoneButtonOnKeyPad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Reset the page count to 1 when the screen appears
        pageCount = 1
        
        //Cancel any running fetch task
        cancelCurrentRoverImageFetchTask()
    }
    
    
    func cancelCurrentRoverImageFetchTask() {
        
        roversImageryDataTask?.cancel()
        roversImageryDataTask = nil
    }
    
    
    private func addDoneButtonOnKeyPad() {
        
        let keyboardToolbar = UIToolbar(frame: .init(x: 0.0, y: 0.0, width: view.frame.size.width, height: 44.0))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(keyPadDoneButtonTapped(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        filterCriteriaTextField.inputAccessoryView = keyboardToolbar
    }
    
    
    private func configureRoverSelectionCriteriaTextFieldDelegate() {
        
        roverSelectionCriteriaTextFieldDelegate = UniverseImageryTextFieldDelegate(withTextField: filterCriteriaTextField, stateHandler: { [unowned self] (state: UniverseImageryTextFieldDelegateState) -> Void in
            
            switch state {
                
            case .editingDidEnd:
                
                //Editing has ended.
                
                if self.filterCriteriaSegmentControl.selectedSegmentIndex == UniverseRoverFilter.sol.rawValue {
                    
                    //Update filter criteria with user selected SOL.
                    
                    let solValue: UInt? = UInt(self.filterCriteriaTextField.text ?? "")
                    if let solValue = solValue {
                        self.filterCriteria = .sol(solValue)
                    }
                }
                else if self.filterCriteriaSegmentControl.selectedSegmentIndex == UniverseRoverFilter.earthDate.rawValue {
                    
                    //Update filter criteria with user selected date.

                    self.updateTextFieldWithDateFromPicker()
                    self.updateFilterCriteriaWithDateFromPicker()
                }
                
            case .returnKeyTapped: self.view.endEditing(true)
                
            default: break
            }
        })
    }
    
    
    private func updateTextFieldWithDateFromPicker() {
        
        if filterCriteriaDatePicker != nil {
            
            //Format and show the date selected on the text field.
            let dateSelected: Date = filterCriteriaDatePicker!.date
            filterCriteriaTextField.text = dateFormatterForDisplay.string(from: dateSelected)
        }
    }
    
    
    private func updateFilterCriteriaWithDateFromPicker() {
        
        if filterCriteriaDatePicker != nil {
            
            //Date selected, formatted as per the needs of the API.

            let dateSelected: Date = filterCriteriaDatePicker!.date
            let df: DateFormatter = DateFormatter()
            df.dateFormat = UniverseRoverCameraCriteria.earthDateFormat
            filterCriteria = .earthDate(df.string(from: dateSelected))
        }
    }
    

    deinit {
        cancelCurrentRoverImageFetchTask()
        selectCameraButton = nil
        filterCriteriaSegmentControl = nil
        filterCriteriaActivationSwitch = nil
        filterCriteriaTextField = nil
        filterCriteriaDatePicker = nil
        cameraType = nil
        filterCriteria = nil
        cameraTypeLabel = nil
        searchResultsIndicatorView = nil
        showResultsButton = nil
        roversImageryDataTask = nil
    }
    
}



extension UniverseRoverCriteriaSelectionViewController {
    
    @IBAction func selectCameraButtonTapped(_ sender: UIButton) {
        
        let cameraSelectionVC: UniverseRoverCameraSelectionViewController = UniverseRoverCameraSelectionViewController(withSelectionHandler: { [unowned self] (camera: String, index: Int?, selectAll: Bool) -> Void in
            
            if selectAll == true {
                self.cameraType = nil
            }
            else if let index = index {
                self.cameraType = UniverseRoverCamera.completeList[index]
            }
            self.cameraTypeLabel.text = camera
        })
        
        let navController: UINavigationController = UINavigationController(rootViewController: cameraSelectionVC)
        present(navController, animated: true, completion: nil)
    }
    
    
    @IBAction func filterCriteriaActivationSwitchToggled(_ sender: UISwitch) {
        
        if sender.isOn == true {
            filterCriteriaTextField.alpha = 1.0
        }
        else {
            filterCriteriaTextField.alpha = 0.4
        }
        filterCriteriaTextField.isUserInteractionEnabled = sender.isOn
    }
    
    
    @IBAction func filterCriteriaSegmentControlTapped(_ sender: UISegmentedControl) {
        
        filterCriteriaTextField.text = nil
        view.endEditing(true)
        
        if sender.selectedSegmentIndex == UniverseRoverFilter.sol.rawValue {
            filterCriteriaTextField.placeholder = "Enter SOL"
            filterCriteria = .sol(0)
            filterCriteriaDatePicker = nil
            filterCriteriaTextField.inputView = nil
        }
        else if sender.selectedSegmentIndex == UniverseRoverFilter.earthDate.rawValue {
            filterCriteriaDatePicker = UniverseImageryDatePicker()
            filterCriteriaTextField.placeholder = "Enter Date"
            filterCriteria = .earthDate("")
            filterCriteriaTextField.inputView = filterCriteriaDatePicker
        }
        
    }
    
    
    @objc func keyPadDoneButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    
    @IBAction func showResultsButtonTapped(_ sender: UIButton) {
        fetchRoverImageData()
    }
    
    
    func fetchRoverImageData(showActivityIndicator show: Bool = true) {
        
        let apiClient: UniverseImageAPI = UniverseImageAPI()
        
        if filterCriteria != nil {
            
            //Filter criteria has been entered.
            
            if filterCriteriaTextField.text == nil || filterCriteriaTextField.text?.isEmpty == true {
                //No text present in the text field. So nil out the filter criteria.
                filterCriteria = nil
            }
        }
        
        var roverEndPoint: UniverseImageryEndpoint = .fetchRoverImage(page: pageCount, fetchCriteria: filterCriteria, cameraType: cameraType)

        if filterCriteriaActivationSwitch.isOn == false {
            roverEndPoint = .fetchRoverImage(page: pageCount, fetchCriteria: nil, cameraType: cameraType)
        }
        
        if show == true {
            //Animate the indicator to signal fetching in progress.
            searchResultsIndicatorView.startAnimating()
            showResultsButton.enable(false, withAlpha: 0.3)
        }
        
        roversImageryDataTask = apiClient.fetchMarsRoverImagery(forEndpoint: roverEndPoint, withCompletionHandler: { [unowned self] (roverDataList: [UniverseImageryRoverData]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    if error.causedByAPICancellation == false {
                        //Error not caused by API cancellation. So display the alert.
                        self.showAlert(withTitle: error.localizedDescription, alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
                    }
                    else {
                        //Error caused by a user initiated API cancellation.
                        //No further execution required.
                        return
                    }
                }
                else {
                    
                    if let roverDataList = roverDataList, self.roversImageryDataTask != nil {
                        
                        //Proceed with processing API data only if roversImageryDataTask is not nil i.e if task hasnt been cancelled.
                        let roverImageViewModels: [UniverseImageViewModel] = roverDataList.map({ (roverData: UniverseImageryRoverData) -> UniverseImageViewModel in
                            
                            return UniverseImageViewModel(withImageData: roverData)
                        })
                        
                        if roverImageViewModels.isEmpty == false {
                            
                            //We have received data matching the given search criteria.
                            
                            //Increment the page count, so that we can fetch the next page if user wishes to see more images matching the criteria he has selected.
                            self.pageCount = self.pageCount + 1
                            
                            var imageCollectionVC: UniverseImageCollectionViewController? = self.navigationController?.topViewController as? UniverseImageCollectionViewController
                            
                            if imageCollectionVC == nil {
                                
                                imageCollectionVC  = UniverseImageCollectionViewController(withImageViewModels: roverImageViewModels, loadMoreTapHandler: { () -> Void in
                                    
                                    self.fetchRoverImageData(showActivityIndicator: false)
                                })
                                self.navigationController?.pushViewController(imageCollectionVC!, animated: true)
                                
                            }
                            else {
                                imageCollectionVC?.addImageViewModels(fromList: roverImageViewModels)
                            }
                        }
                        else {
                            if self.pageCount == 1 {
                                //Display alert only when fetching the first page of the given criteria
                                //No matching data found. Show an alert.
                                self.showAlert(withTitle: "No data matching the given search/filter criteria found. Refine the search criteria and try again", alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
                            }
                            else {
                                //Have reached the end of search results i.e data from all pages have been fetched.
                                
                                let imageCollectionVC: UniverseImageCollectionViewController = self.navigationController?.topViewController as! UniverseImageCollectionViewController
                                imageCollectionVC.addImageViewModels(fromList: [])
                                
                            }
                            
                        }
                        
                    }
                }
                
                if show == true {
                    //Stop animating the indicator to signal end of fetching.
                    self.searchResultsIndicatorView.stopAnimating()
                    self.showResultsButton.enable(true)
                }
            }
            
        })
    }
}
