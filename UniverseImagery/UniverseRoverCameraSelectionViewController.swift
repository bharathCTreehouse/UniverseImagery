//
//  UniverseRoverCameraSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 07/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseRoverCameraSelectionViewController: UIViewController {
    
    @IBOutlet var cameraListTableView: UITableView!
    
    let selectionHandler: ((String, Int) -> Void)
    
    lazy private(set) var cameraDescList: [String] = {
        return UniverseRoverCamera.completeList.descriptionList()
    }()
    
    
    init(withSelectionHandler handler: @escaping ((String, Int) -> Void)) {
        selectionHandler = handler
        super.init(nibName: "UniverseRoverCameraSelectionViewController", bundle: .main)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCameraListTableView()
        navigationItem.title = "SELECT CAMERA"
    }
    
    
    func configureCameraListTableView() {
        
        cameraListTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cameraCell")
        cameraListTableView.dataSource = self
        cameraListTableView.delegate = self
        cameraListTableView.estimatedRowHeight = 60.0
        cameraListTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    deinit {
        cameraListTableView = nil
    }
}



extension UniverseRoverCameraSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameraDescList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cameraCell", for: indexPath)
        let cameraDesc: String = cameraDescList[indexPath.row]
        cell.textLabel!.textAlignment = .center
        cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 22.0)
        cell.textLabel!.text = cameraDesc
        
        return cell
        
    }
    
}



extension UniverseRoverCameraSelectionViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraDesc: String = cameraDescList[indexPath.row]
        selectionHandler(cameraDesc, indexPath.row)
        dismiss(animated: true, completion: nil)
    }

}
