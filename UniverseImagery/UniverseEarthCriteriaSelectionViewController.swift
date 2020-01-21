//
//  UniverseEarthCriteriaSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 19/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit
import MapKit

class UniverseEarthCriteriaSelectionViewController: UIViewController {

    @IBOutlet weak var locationListTableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    private var localSearch: MKLocalSearch? = nil
    lazy var earthLocationViewModels: [UniverseEarthLocationInfoViewModel] = {
       return []
    }()
    
    
    init() {
        super.init(nibName: "UniverseEarthCriteriaSelectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "EARTH LOCATION SELECTION"
    }
    
    
    deinit {
        locationListTableView = nil
        locationSearchBar = nil
        localSearch = nil
    }
}


extension UniverseEarthCriteriaSelectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        earthLocationViewModels.removeAll()
        searchBar.resignFirstResponder()
        
        let searchRequest: MKLocalSearch.Request = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch!.start { [unowned self] (searchResponse, searchError) in
            
            if let error = searchError {
                self.showAlert(withTitle: error.localizedDescription, alertMessage: nil, cancelActionTitle: nil, defaultActionTitles: ["OK"], destructiveActionTitles: nil, actionTapHandler: nil)
            }
            else if let response = searchResponse {
                
                let searchResultMapItems: [MKMapItem] = response.mapItems
                
                for mapItem in searchResultMapItems {
                    
                    let locInfo: UniverseEarthLocationInfo = UniverseEarthLocationInfo(locationName: mapItem.name, locationPlacemark: mapItem.placemark)
                    self.earthLocationViewModels.append(UniverseEarthLocationInfoViewModel(withLocationInfo: locInfo))
                    
                }
                
            }
            self.locationListTableView.reloadData()

        }
    }
}



extension UniverseEarthCriteriaSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthLocationViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let locationViewModel: UniverseEarthLocationInfoViewModel = earthLocationViewModels[indexPath.row]
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "locationListCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationListCell")
        }
        cell!.backgroundColor = UIColor.black
        
        let locationNameDetail = locationViewModel.locationNameDisplayableDetail
        cell!.textLabel?.text = locationNameDetail.text
        cell!.textLabel?.font = locationNameDetail.font
        cell!.textLabel?.textColor = locationNameDetail.color
        
        let addressDetail = locationViewModel.addressDisplayableDetail
        cell!.detailTextLabel?.text = addressDetail.text
        cell!.detailTextLabel?.font = addressDetail.font
        cell!.detailTextLabel?.textColor = addressDetail.color
        
        return cell!
    }
}



extension UniverseEarthCriteriaSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let locationViewModel: UniverseEarthLocationInfoViewModel = earthLocationViewModels[indexPath.row]
        let location: CLLocation? = locationViewModel.locationInfo.locationPlacemark.location
        
        if let location = location {
            
            let dateSelectionVC: UniverseEarthDateSelectionViewController = UniverseEarthDateSelectionViewController(withLocationCoordinate: location.coordinate, addressString: "\(locationViewModel.locationNameDisplayableDetail.text), \(locationViewModel.addressDisplayableDetail.text)")
            navigationController?.pushViewController(dateSelectionVC, animated: true)
        }
    }
}
