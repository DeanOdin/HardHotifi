//
//  MyTableViewController.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 01.10.2022.
//

import UIKit
import SwiftUI
import SpriteKit

class MyTableViewController: UITableViewController {

    var audioList:[AudioFile] = [AudioFile]()
    private let skView = SKView()
    
    
    
    
    @IBOutlet var playTableView: UITableView!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playTableView.separatorStyle = .none
        
        previewImageSet() //?????
        fetchData() // ??????????
        setupUI() // искры
        initSKScene() // искры
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(actionLongPress))
        longPress.minimumPressDuration = 0.5
        tableView.addGestureRecognizer(longPress)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return audioList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
        guard let cell = tableView.cellForRow(at: <#T##IndexPath#>) as?
    */
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        Audio.current.playVoice(file: audioList[indexPath.row])
                   
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
        
        previewImageSet()
        
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
                self.tableView.reloadData()
                
            }
            
        }
        catch {
            print("error")
        }
    }
    
    func previewImageSet() {
        // Упрощенный  if else
        let color: UIColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        previewImage.image = previewImage.image?.mask(with: color)
    }
    
    @objc func actionLongPress(Recognizer: UILongPressGestureRecognizer) {
        
        // Получаю ячейку в пространстве
        //let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Получаю ячейку конкретно из tableview
        let point = Recognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        let cell = tableView.cellForRow(at: indexPath)!
        
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
    
    @IBOutlet weak var Scaleimage: UIImageView!
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(skView)
        skView.translatesAutoresizingMaskIntoConstraints = false
        let top = skView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let leading = skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailing = skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottom = skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func initSKScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        particleScene.backgroundColor = .clear
        
        skView.presentScene(particleScene)
        
     }
    
    
    
}

   
