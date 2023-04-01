//
//  SaveAudio.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 05.01.2023.
//

import Foundation
import UIKit

class SaveAudio {
    
    var curFileName: String!
    
    static var current = SaveAudio()
    
    func saveFileLocalFile(file: AudioFile) {
        
        //let url = Bundle.main.url(forResource: file.name, withExtension: file.ext, subdirectory: "Audio.bundle")!
        //curFileName = file.name
        
        // let file = fileName
        
        //curFileName = file.name + "." + file.ext
        
        let fileManager = FileManager.default
        let url = Bundle.main.url(forResource: file.name, withExtension: "m4a", subdirectory: "Audio.bundle")!
        //let item = AVPlayerItem(url: url)
        
        let contents = fileManager.contents(atPath: url.path)
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file.name + "." + file.ext)
        
        do {
            //TODO:
            //MARK: contents - содержимое из пути, fileURL - путь куда + имя файла
            try contents!.write(to: fileURL)
        //    print(UIDevice.modelName)
      
        }
        
        catch {
            print("Error \(error)")
        }
    }
    
}

