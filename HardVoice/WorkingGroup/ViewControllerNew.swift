//
//  ViewControllerNew.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 20.11.2022.
//

import UIKit
import SwiftUI
import SpriteKit
import MessageUI
import CloudKit
import AVFoundation


class ViewControllerNew: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableOnView: UITableView!
    @IBOutlet weak var skviewParticles: SKView!
    @IBOutlet weak var previewImage: UIImageView!
    
    private var audioList: [AudioFile] = [AudioFile]()
    
    private var cellSelectedIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImageSet() //смена цвета иконки в зависимости от темы
        tableOnView.separatorStyle = .none
        fetchData()
        
        
        
        
        // Scene
               if let scene = SKScene(fileNamed: "Scene.sks") {
                    
                    if let sceneNode = scene as! ParticleScene? {
                        
                        sceneNode.scaleMode = .aspectFill
                        
                        // Present the scene
                        skviewParticles.presentScene(sceneNode)
                        skviewParticles.ignoresSiblingOrder = true
             
                    }
                }
    
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(actionLongPress))
        longPress.minimumPressDuration = 0.5
        tableOnView.addGestureRecognizer(longPress)
        
    }
    
    
    
    // MARK: - Table view data source

    func numberOfSections (in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return audioList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: UITableViewCell? = tableOnView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            print(indexPath, "cellForRow")
            
            //var content = cell!.defaultContentConfiguration()
            //content.text = audioList[indexPath.row].caption
            //content.textProperties.font = UIFont.init(name: "Base 02 Cyrillic"/*"ASPHALTIC SCRATCH(RUS BY LYAJKA"*/, size: 22 )!
            //content.textProperties.alignment = .center
            //cell!.contentConfiguration = content
            //
            cell?.textLabel?.text = audioList[indexPath.row].caption
            cell?.textLabel?.font = UIFont.init(name: "Base 02 Cyrillic"/*"ASPHALTIC SCRATCH(RUS BY LYAJKA"*/, size: 22 )
            print(cell?.textLabel!.text)
           
            /*
            let backgroundview = UIView()
            backgroundview.backgroundColor = UIColor.red
            cell?.selectedBackgroundView = backgroundview
            */
            return cell!
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
        guard let cell = tableView.cellForRow(at: <#T##IndexPath#>) as?
    */
       // let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        Audio.current.playVoice(file: audioList[indexPath.row])
       
                   
    }
    
    func fetchData() {
        guard let fileLocation = Bundle.main.url(forResource: "audios", withExtension: "json")
        else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([AudioFile].self, from: data)
            
            audioList = receivedData
            
            DispatchQueue.main.async {
                self.tableOnView.reloadData()
                
            }
            
        }
        catch {
            print("error")
        }
    }
    
    func previewImageSet() {
        // Упрощенный  if else
        let color: UIColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        /*previewImage.image = previewImage.image?.mask(with: color)*/
        previewImage.image = previewImage.image?.mask(with: color)
    }
    
    @objc func actionLongPress(Recognizer: UILongPressGestureRecognizer) {
        
        // Получаю ячейку в пространстве
        //let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Получаю ячейку конкретно из tableview
        //let point = Recognizer.location(in: tableOnView)
        //guard let indexPath = tableOnView.indexPathForRow(at: point) else { return }
        //let cell = tableOnView.cellForRow(at: indexPath)!
        
        var fontSize: CGFloat = 22.0
        
        switch(Recognizer.state) {
        case .began:
            var point = Recognizer.location(in: tableOnView)
            guard let indexPath = tableOnView.indexPathForRow(at: point) else { return }
            cellSelectedIndex = indexPath
            fontSize = 26.0
            
            showAlert()
            HapticsManager.instanse.impact(style: .soft)
            
           
            
        default:
            break
            
        }
       
        // TODO: fix deprecated method "textLabel"
        var cell = tableOnView.cellForRow(at: cellSelectedIndex)!
        cell.textLabel?.font = UIFont.init(name: "Base 02 Cyrillic"/*"ASPHALTIC SCRATCH(RUS BY LYAJKA"*/, size: fontSize )
        
        //var cell: UITableViewCell? = tableOnView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //print(indexPath, "cellForRow")
        
        //var content = cell!.defaultContentConfiguration()
        //content.text = audioList[indexPath.row].caption
        //content.textProperties.font = UIFont.init(name: "Base 02 Cyrillic"/*"ASPHALTIC SCRATCH(RUS BY LYAJKA"*/, size: 22 )!
        //content.textProperties.alignment = .center
        //cell!.contentConfiguration = content
        
         
        
    }
    
    func showAlert(){
        
       
        
        let alert = UIAlertController(title: "Сохранить цитату?", message: self.audioList[self.cellSelectedIndex.row].caption, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ок", style: .default) {
            (action) in
                SaveAudio.current.saveFileLocalFile(file: self.audioList[self.cellSelectedIndex.row])
                let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let alertSave = UIAlertController(title: "Сохранено!", message: "Файлы → iPhone → HardVoice", preferredStyle: .alert)
                let OkayAction = UIAlertAction(title: "Ок", style: .default)
                alertSave.addAction(OkayAction)
                self.present(alertSave, animated: true)
           
        }
        
        let delAction = UIAlertAction(title: "Отмена", style: .default) {
            (action) in
        }
        
        alert.addAction(saveAction)
        alert.addAction(delAction)
        
        
        
        present(alert, animated: true)
        
    }
    
    @objc func handleTap(sender: UITableView) {
            print("tap")
    }
    
  
    @IBAction func btSendM(_ sender: Any) {
    // HapticsManager.instanse.impact(style: .heavy)
        present(ViewControllerSendMail.instance , animated: true)
    /* if MFMailComposeViewController .canSendMail()
        {
         print("success")
     }
        else
        {
            print("error")
        }*/
    }
    
    
     
    
    
 
    
    
    
  
    
    
 /*   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
        
        previewImageSet()
        
        }*/
    
    
    
    
}
