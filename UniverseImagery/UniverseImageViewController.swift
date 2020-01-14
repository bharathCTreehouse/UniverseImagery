//
//  UniverseImageViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 14/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class UniverseImageViewController: UIViewController {
    
    @IBOutlet weak var universeImageView: UIImageView!
    @IBOutlet weak var postCardTextLabel: UILabel!

    let universeImage: UIImage
    
    
    init(withUniverseImage image: UIImage) {
        universeImage = image
        super.init(nibName: "UniverseImageViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup navigation item buttons.
        configureNavigationButtonItems()
        
        universeImageView.image = universeImage
    }
    
    
    func configureNavigationButtonItems() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .reply, target: self, action: #selector(sendButtonTapped(_:)))
        
        let editButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
        let closeButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped(_:)))
        navigationItem.leftBarButtonItems = [closeButton, editButton]
    }
    
    
    @objc func sendButtonTapped(_ sender: UIBarButtonItem) {
        
        //Attach the image and send it through.
        
        if postCardTextLabel.isHidden == false {
            
            UIGraphicsBeginImageContext(universeImageView.frame.size)
            
            if let currentContext = UIGraphicsGetCurrentContext() {
                
                view.layer.render(in: currentContext)
                let postCardImage = UIGraphicsGetImageFromCurrentImageContext()
                let newImageVC: TempViewController = TempViewController(withImg: postCardImage!)
                navigationController?.pushViewController(newImageVC, animated: true)
                
            }
        }
    }
    
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        
        //Show an alert controller with a text field.
        
        let alertCont: UIAlertController = UIAlertController(title: "Add text for post card", message: nil, preferredStyle: .alert)
        
        alertCont.addTextField(configurationHandler: { (textFld: UITextField) -> Void in
            textFld.placeholder = "Enter post card text"
        })
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (action: UIAlertAction) -> Void in
            
            let postCardText: String? = alertCont.textFields?.first?.text
            if let postCardText = postCardText, postCardText.isEmpty == false {
                self.postCardTextLabel.isHidden = false
                self.postCardTextLabel.text = postCardText
            }
            
        })
        alertCont.addAction(okAction)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
        alertCont.addAction(cancelAction)
        
        present(alertCont, animated: true, completion: nil)
    }
    
    
    @objc func closeButtonTapped(_ sender: UIBarButtonItem) {
        //dismiss the controller
        dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        universeImageView = nil
        postCardTextLabel = nil
    }
    
}
