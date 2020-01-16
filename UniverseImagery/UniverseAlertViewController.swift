//
//  UniverseAlertViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 07/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func  showAlert(withTitle alertTitle: String? = nil, alertMessage: String? = nil, cancelActionTitle cancelTitle: String? = nil, defaultActionTitles defaultTitles: [String], destructiveActionTitles destTitles: [String]? = nil, actionTapHandler tapHandler: ((Int) -> Void)?) {
        
        let alertController: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        for defTitle in defaultTitles {
            let alertAction: UIAlertAction = UIAlertAction(title: defTitle, style: .default, handler: { (act: UIAlertAction) -> Void in
                
                tapHandler?(alertController.actions.firstIndex(of: act)!)
            })
            alertController.addAction(alertAction)
        }
        
        if let cancelTitle = cancelTitle {
            let cancelAct: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: {(act: UIAlertAction) -> Void in
                
                tapHandler?(alertController.actions.firstIndex(of: act)!)
                
            })
            alertController.addAction(cancelAct)
        }
        
        if let destTitles = destTitles {
            
            for destTitle in destTitles {
                let alertAction: UIAlertAction = UIAlertAction(title: destTitle, style: .destructive, handler: { (act: UIAlertAction) -> Void in
                    
                    tapHandler?(alertController.actions.firstIndex(of: act)!)
                    
                    
                })
                alertController.addAction(alertAction)
            }
        }
        
        present(alertController, animated: true, completion: nil)
        
    }
}
