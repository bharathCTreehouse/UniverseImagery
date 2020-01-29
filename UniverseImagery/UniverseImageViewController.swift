//
//  UniverseImageViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 14/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit
import MessageUI

class UniverseImageViewController: UIViewController {
    
    @IBOutlet weak private(set) var universeImageView: UIImageView!
    @IBOutlet weak private(set) var postCardTextLabel: UILabel!
    var emailConfigurer: UniverseImageEmailConfigurer! = nil

    let universeImage: UIImage
    private var postCardImage: UIImage? = nil
    
    
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
        
        UIGraphicsBeginImageContext(universeImageView.frame.size)
        
        if let currentContext = UIGraphicsGetCurrentContext() {
            
            //Form new image with the post card text.
            view.layer.render(in: currentContext)
            postCardImage = UIGraphicsGetImageFromCurrentImageContext()
            
            if postCardImage != nil {
                //New image creation successful.
                sendEmailWithPostCardImage()
            }
            else {
                //Could not create new image with text. Show an alert.
                let alertCont: UIAlertController = UIAlertController(title: "Could not attach image. Please try again.", message: nil, preferredStyle: .alert)
                let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertCont.addAction(okAction)
                present(alertCont, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func sendEmailWithPostCardImage() {
        
        emailConfigurer =  UniverseImageEmailConfigurer(withEmailDataSource: self, configurationCompletionHandler: { [unowned self] (mailComposeVC: MFMailComposeViewController?) -> Void in
            
            if mailComposeVC == nil {
                let alertCont: UIAlertController = UIAlertController(title: "Email not configured to be sent from this device", message: nil, preferredStyle: .alert)
                let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertCont.addAction(okAction)
                self.present(alertCont, animated: true, completion: nil)
            }
            else {
                self.present(mailComposeVC!, animated: true, completion: nil)
            }
            
            }, compositionCompletionHandler: { (emailComposeState: UniverseImageEmailComposeState, mailController: MFMailComposeViewController) -> Void in
                
                mailController.dismiss(animated: true, completion: nil)
                
                var stateDescription: String? = nil
                switch emailComposeState {
                    case .sent: stateDescription = "Email sent successfully!"
                    case .failed(errorText: let errDesc): stateDescription = errDesc
                    default: break
                }
                if stateDescription != nil {
                    let alertCont: UIAlertController = UIAlertController(title: stateDescription, message: nil, preferredStyle: .alert)
                    let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                    alertCont.addAction(okAction)
                    self.present(alertCont, animated: true, completion: nil)
                }
        })
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
        emailConfigurer = nil
    }
    
}


extension UniverseImageViewController: UniverseImageEmailDataSource {
    
    var toAddresses: [String] {
        return []
    }
    var ccAddresses: [String] {
        return []
    }
    var bccAddresses: [String] {
        return []
    }
    var emailSubject: String {
        return "Post card from Universe Imagery"
    }
    var emailBodyDetail: (text: String, html: Bool) {
        return (text: "Greetings.  Enjoy the card dude.", html: true)
    }
    var emailAttachments: [(data: Data, mime: String, fileName: String)] {
        let imageData = postCardImage?.jpegData(compressionQuality: 1.0)
        if let imageData = imageData {
            return [(data: imageData, mime: "image/jpeg", fileName: "PostCard")]
        }
        else {
            return []
        }
    }
}
