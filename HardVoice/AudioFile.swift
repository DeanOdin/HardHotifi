//
//  AudioFile.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 01.10.2022.
//

import Foundation

struct AudioFile: Codable, Identifiable {
    let id: Int
    let caption: String
    let name: String
    let ext: String 
}
