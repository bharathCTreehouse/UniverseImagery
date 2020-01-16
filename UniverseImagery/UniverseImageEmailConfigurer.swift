//
//  UniverseImageEmailConfigurer.swift
//  UniverseImagery
//
//  Created by Bharath on 15/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

enum UniverseImageEmailComposeState {
    case cancelled
    case failed(errorText: String?)
    case sent
}


class UniverseImageEmailConfigurer: NSObject, MFMailComposeViewControllerDelegate {
    
    let emailDataSource: UniverseImageEmailDataSource
    let emailConfigurationCompletionHandler: ((MFMailComposeViewController?) -> Void)
    let emailCompositionCompletionHandler: ((UniverseImageEmailComposeState, MFMailComposeViewController) -> Void)

    
    required init(withEmailDataSource dataSource: UniverseImageEmailDataSource, configurationCompletionHandler handler:  @escaping ((MFMailComposeViewController?) -> Void), compositionCompletionHandler compoHandler: @escaping ((UniverseImageEmailComposeState, MFMailComposeViewController) -> Void)) {
        
        emailDataSource = dataSource
        emailCompositionCompletionHandler = compoHandler
        emailConfigurationCompletionHandler = handler
        super.init()
        configureEmail()
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let error = error {
            emailCompositionCompletionHandler(.failed(errorText: error.localizedDescription), controller)
        }
        else {
            if result == .cancelled {
                emailCompositionCompletionHandler(.cancelled, controller)
            }
            else if result == .failed {
                emailCompositionCompletionHandler(.failed(errorText: nil), controller)
            }
            else if result == .sent {
                emailCompositionCompletionHandler(.sent, controller)
            }
        }
    }
    
    func configureEmail() {
        
        if MFMailComposeViewController.canSendMail() == false {
            //Can't send email from this device. So return with nil.
            emailConfigurationCompletionHandler(nil)
        }
        else {
            
            let mailComposeVC: MFMailComposeViewController = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(emailDataSource.toAddresses)
            mailComposeVC.setCcRecipients(emailDataSource.ccAddresses)
            mailComposeVC.setBccRecipients(emailDataSource.bccAddresses)
            mailComposeVC.setSubject(emailDataSource.emailSubject)
            mailComposeVC.setMessageBody(emailDataSource.emailBodyDetail.text, isHTML: emailDataSource.emailBodyDetail.html)
            
            for attachment in emailDataSource.emailAttachments {
                mailComposeVC.addAttachmentData(attachment.data, mimeType: attachment.mime, fileName: attachment.fileName)
            }
            //Call the handler with configured mail compose VC.
            emailConfigurationCompletionHandler(mailComposeVC)
        }
    }

}
