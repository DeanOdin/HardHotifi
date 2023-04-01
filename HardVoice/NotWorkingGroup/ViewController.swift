//
//  ViewController.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 03.01.2022.
//
// NOT WORK!!!!!!!!!!

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
    
    
    
    //saveAudio
    func saveAudio(fileName: String) {
        print("1")
        let file = fileName
        let fileManager = FileManager.default
        let url = Bundle.main.url(forResource: file, withExtension: "m4a", subdirectory: "Audio.bundle")!
        let contents = fileManager.contents(atPath: url.path)
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            //TODO:
            //MARK: contents - содержимое из пути, fileURL - путь куда + имя файла
            try contents!.write(to: fileURL)
            print(UIDevice.modelName)
        }
        
        catch {
            print("Error \(error)")
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
        //HapticsManager.instanse.impact(style: .medium)
        // saveVoiceToDir(fileName: "dadova", fileExt: "m4a")
    }
    @IBAction func btSupport(_ sender: Any) {
        HapticsManager.instanse.impact(style: .heavy)
        sendEmail()
    }
    
    @IBAction func btPlay1(_ sender: Any) {
        playVoice(fileName: "dadova", fileExt: "mp3")
    }
    @IBAction func btPlay2(_ sender: Any) {
        playVoice(fileName: "salut", fileExt: "m4a")
    }
    @IBAction func btSave2(_ sender: Any) {
        saveAudio(fileName:"nikakogo_prazdnika.m4a")
    }
    @IBAction func btPlay3(_ sender: Any) {
        playVoice(fileName: "nikakogo_prazdnika", fileExt: "m4a")
    }
    @IBAction func btPlay4(_ sender: Any) {
        playVoice(fileName: "bros_bulku", fileExt: "m4a")
    }
    @IBAction func btPlay5(_ sender: Any) {
        playVoice(fileName: "jresh", fileExt: "m4a")
    }
    @IBAction func btPlay6(_ sender: Any) {
        playVoice(fileName: "hahaha_fear", fileExt: "m4a")
    }
    @IBAction func btPlay7(_ sender: Any) {
        playVoice(fileName: "neponimay", fileExt: "m4a")
    }
    @IBAction func btPlay8(_ sender: Any) {
        playVoice(fileName: "s_takimi_glazami", fileExt: "m4a")
    }
    @IBAction func btPlay9(_ sender: Any) {
        playVoice(fileName: "paraparapam", fileExt: "m4a")
    }
    @IBAction func btPlay10(_ sender: Any) {
        playVoice(fileName: "auf", fileExt: "m4a")
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

    /*
    func saveVoiceToDir(fileName: String, fileExt: String) -> Void {
     
    
    
        let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)
        let documentDirectoryURL = containerURL!.appendingPathComponent("Documents")
        let documentURL = documentDirectoryURL.appendingPathComponent("dadova.m4a")
    

    }
     */
        
        @objc func playerItemDidFinishPlaying(sender: Notification) {
            
            print("playing styped")
    
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
    

