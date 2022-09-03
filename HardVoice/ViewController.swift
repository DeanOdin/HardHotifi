//
//  ViewController.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 03.01.2022.
//

import UIKit
import AVKit

import AVFAudio
import AVFoundation
import MessageUI



class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var musicPlayer: AVPlayer!
    var a = 1
    
    

    // ReportSender
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kandra10kov@gmail.com"])
            mail.setMessageBody("<p> Пачините. Не работает</p>" , isHTML: true)
            mail.setSubject("Testing HardVoice")

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    @IBAction func play_1(_ sender: Any) {
        //musicPlayer.play()
        //playVoice(fileName: "dadova", fileExt: "m4a")
        //sendEmail()
        // print(UIDevice.modelName)
        
        print(1);
        let file = "track.mp3"

        let fileManager = FileManager.default
        
        let url = Bundle.main.url(forResource: "dadova", withExtension: "mp3", subdirectory: "Audio.bundle")!
        
        let contents = fileManager.contents(atPath: url.path)
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            //TODO:
            //MARK: contents - содержимое из пути, fileURL - путь куда + имя файла
            
            try contents!.write(to: fileURL)
            
            print(2);
        }
        
        catch {
            print("Error \(error)")
        }
        print(3);

        
    }
    
    @IBAction func stop_1(_ sender: Any) {
    
        // print(UIDevice.modelName)
        sendEmail()
        
    }
    
    @IBAction func save_1(_ sender: Any) {
        
        saveVoiceToDir(fileName: "dadova", fileExt: "m4a")
        
    }
    
    override func viewDidLoad() {
      
    }
    
    /**
        Start strimer"voice
     - parameter fileName:Name of the audio file
     - parameter fileExt: Extension of the audio file
     */
    func playVoice(fileName: String, fileExt: String) -> Void {
        let url = Bundle.main.url(forResource: fileName, withExtension: fileExt, subdirectory: "Audio.bundle")!
        
        let item = AVPlayerItem(url: url)
        
        musicPlayer = AVPlayer(playerItem: item)
        musicPlayer.play()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerItemDidFinishPlaying(sender:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
    }

    
    func saveVoiceToDir(fileName: String, fileExt: String) -> Void {
     
    
    /*
        let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)
        let documentDirectoryURL = containerURL!.appendingPathComponent("Documents")
        let documentURL = documentDirectoryURL.appendingPathComponent("dadova.m4a")
    */

    }

        
        @objc func playerItemDidFinishPlaying(sender: Notification) {
            
            print("playing styped")
    
        }

}
    

