//
//  MyTableViewController.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 01.10.2022.
//

import UIKit

class MyTableViewController: UITableViewController {

    var audioList:[AudioFile] = [AudioFile]()
    
    @IBOutlet var playTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playTableView.separatorStyle = .none
        

        fetchData()
        
        

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
            
            cell?.textLabel?.text = audioList[indexPath.row].caption
            return cell!
 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
        guard let cell = tableView.cellForRow(at: <#T##IndexPath#>) as?
    */
        
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
                self.tableView.reloadData()
                
            }
            
            
        }
        catch {
            print("error")
        }
    }
}

   
