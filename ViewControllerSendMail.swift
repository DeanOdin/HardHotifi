//
//  SendMail.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 25.02.2023.
//
import UIKit
import MessageUI
import CloudKit
import SwiftUI
import ContactsUI



class ViewControllerSendMail: UIViewController, MFMailComposeViewControllerDelegate {
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendEmail()
    }*/
    
    override func  viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        configureMailComposer()
        //let recipientEmail = "kandra10kov@gmail.com"
        
     
    }
    
    /*
    @IBAction func sendEmailBtn(_ sender: Any) {
        let mailComposeViewController = configureMailComposer()
        
        if MFMailComposeViewController.canSendMail() {
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else {
            print("error")
        }
    }
    */
    
    
    func configureMailComposer() -> MFMailComposeViewController {
        
        
        if MFMailComposeViewController.canSendMail() {
            
            print("success")//self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else {
            print("error")
        }
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["kandra10kov@gmail.com"])
        mail.setMessageBody("<p> Пачините. Не работает</p>" , isHTML: true)
        mail.setSubject("Testing HardVoice")
        self.present(mail, animated: true)
        
        
        return mail
    }
    
    static let instance = ViewControllerSendMail()
    /*
    // ReportSender
    func sendEmail() {
       if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kandra10kov@gmail.com"])
            mail.setMessageBody("<p> Пачините. Не работает</p>" , isHTML: true)
            mail.setSubject("Testing HardVoice")
            
            self.present(mail, animated: true)
    
        } else {
            print("fail")// show failure alert
        }
    }
     */
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true)
        
        switch result {
                case .sent:
                    print("Email sent")
                case .saved:
                    print("Draft saved")
                case .cancelled:
                    print("Email cancelled")
                case  .failed:
                    print("Email failed")
                }
   
    }
    
    
}
