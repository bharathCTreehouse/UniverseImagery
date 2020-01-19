//
//  UniverseEarthCriteriaSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath Chandrashekar on 19/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseEarthCriteriaSelectionViewController: UIViewController {

    @IBOutlet weak var locationListTableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    
    init() {
        super.init(nibName: "UniverseEarthCriteriaSelectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationListTableView.dataSource = self
        locationListTableView.delegate = self
        locationListTableView.estimatedRowHeight = 50.0
        locationListTableView.rowHeight = UITableView.automaticDimension
        locationListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationListCell")
        
    }
    
    
    deinit {
        locationListTableView = nil
        locationSearchBar = nil
    }
}



extension UniverseEarthCriteriaSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "locationListCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = "India"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 19.0)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}



extension UniverseEarthCriteriaSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
