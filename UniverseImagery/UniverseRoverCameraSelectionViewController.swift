//
//  UniverseRoverCameraSelectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 07/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseRoverCameraSelectionViewController: UIViewController {
    
    @IBOutlet private(set) var cameraListTableView: UITableView!
    
    let selectionHandler: ((String, Int?, Bool) -> Void)
    
    lazy private(set) var cameraDescList: [String] = {
        return UniverseRoverCamera.completeList.descriptionList()
    }()
    
    
    init(withSelectionHandler handler: @escaping ((String, Int?, Bool) -> Void)) {
        selectionHandler = handler
        super.init(nibName: "UniverseRoverCameraSelectionViewController", bundle: .main)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCameraListTableView()
        configureSelectAllButton()
        navigationItem.title = "SELECT CAMERA"
    }
    
    
    private func configureCameraListTableView() {
        
        cameraListTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cameraCell")
        cameraListTableView.dataSource = self
        cameraListTableView.delegate = self
        cameraListTableView.estimatedRowHeight = 60.0
        cameraListTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    private func configureSelectAllButton() {
        
        let selectAllButton: UIButton = UIButton(type: .system)
        selectAllButton.frame = .init(x: 0.0, y: 0.0, width: view.frame.size.width, height: 50.0)
        selectAllButton.setTitle("Select All", for: .normal)
        selectAllButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19.0)
        selectAllButton.addTarget(self, action: #selector(selectAllButtonTapped(_:)), for: .touchUpInside)
        cameraListTableView.tableFooterView = selectAllButton
    }
    
    
    @objc func selectAllButtonTapped(_ sender: UIButton) {
        selectionHandler("All", nil, true)
        dismiss(animated: true, completion: nil)
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
        cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 19.0)
        cell.textLabel!.text = cameraDesc
        cell.textLabel!.numberOfLines = 0
        
        return cell
        
    }
    
}


extension UniverseRoverCameraSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraDesc: String = cameraDescList[indexPath.row]
        selectionHandler(cameraDesc, indexPath.row, false)
        dismiss(animated: true, completion: nil)
    }
}
