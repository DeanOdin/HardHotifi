//
//  ViewControllerNew.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 20.11.2022.
//

import UIKit
import SwiftUI
import SpriteKit

class ViewControllerNew: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableOnView: UITableView!
    var audioList:[AudioFile] = [AudioFile]()
    @IBOutlet weak var skviewParticles: SKView!
    @IBOutlet weak var previewImage: UIImageView!
    
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
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
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
        let point = Recognizer.location(in: tableOnView)
        guard let indexPath = tableOnView.indexPathForRow(at: point) else { return }
        let cell = tableOnView.cellForRow(at: indexPath)!
        
        if Recognizer.state == .began {
            //print(indexPath, cell.textLabel!.text)
            cell.textLabel!.font = UIFont.init(name: "Base 02 Cyrillic" /*"ASPHALTIC SCRATCH(RUS BY LYAJKA"*/, size: 24)
            cell.textLabel!.textColor = UIColor.red
            HapticsManager.instanse.impact(style: .soft)
        }
        else if Recognizer.state == .ended {
            cell.textLabel!.font = UIFont.init(name: "Base 02 Cyrillic"/*"ASPHALTIC SCRATCH(RUS BY LYAJKA*/, size: 22)
            cell.textLabel!.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
  
    
    
 /*   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
        
        previewImageSet()
        
        }*/
    
    
    
    
}
