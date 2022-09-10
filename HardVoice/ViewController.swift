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
import CloudKit
import SwiftUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var musicPlayer: AVPlayer!
    var a = 1
    var i = 0
    

        
    
    
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
        tapped()
        
    }
    @IBAction func btSupport(_ sender: Any) {
        
        tapped()
        sendEmail()
    
    }
    
    
    @IBAction func save_1(_ sender: Any) {
        
       // saveVoiceToDir(fileName: "dadova", fileExt: "m4a")
       
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "sgHelpScreen":
//            segue.destination.help
//        }
//    }
    
    
    
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
  
    /*
    override func viewDidLoad() {
            super.viewDidLoad()

            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(btn)

            btn.widthAnchor.constraint(equalToConstant: 128).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 128).isActive = true
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            btn.setTitle("Tap here!", for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
     */

        @objc func tapped() {
            i += 1
            print("Running \(i)")

            switch i {
            case 1:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)

            case 2:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)

            case 3:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)

            case 4:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()

            case 5:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()

            case 6:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()

            default:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                i = 0
            }
        }
    
}

    


/*
 
// habr.com/ru/company/youla/blog/456394/
 // Создание анимированного экрана приветствия. Появление главного меню из иконки
 
final class SplashViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var textImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textImageView.image = textImage
        
    }
    
    
}

protocol SplashPresenterDescription: AnyObject {
    //class
    
    func present()
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter: SplashPresenterDescription {
     func present() {
        // Пока оставим метод пустым
     }
     
    func dismiss(completion: @escaping () -> Void) {
        // Пока оставим метод пустым
    }
}

private var textImage: UIImage? = {
        let textsCount = 17
        
        let imageNumber = Int.random(in: 1...textsCount)
        let imageName = "preview\(imageNumber)"
        
        return UIImage(named: imageName)
    }()

@MainActor class UIWindow : UIView {
    
}
 */
    

