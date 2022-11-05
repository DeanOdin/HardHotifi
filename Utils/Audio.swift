//
//  Audio.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 08.10.2022.
//
import AVKit
import AVFAudio
import AVFoundation

class Audio {
    
    var musicPlayer: AVPlayer!
    var isPlaying: Bool = false
    var curFileID: Int!
    
    static var current = Audio()
    
    /**
        Start strimer"voice
     - parameter fileName:Name of the audio file
     - parameter fileExt: Extension of the audio file
     */
    func playVoice(file: AudioFile) {
        
        if isPlaying,curFileID == file.id  {
            musicPlayer.pause()
            isPlaying = false
            return
        }
        
        let url = Bundle.main.url(forResource: file.name, withExtension: file.ext, subdirectory: "Audio.bundle")!
        
        let item = AVPlayerItem(url: url)
        
        musicPlayer = AVPlayer(playerItem: item)
        musicPlayer.play()
        isPlaying = true
        curFileID = file.id
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerItemDidFinishPlaying(sender:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
    }
    
    @objc func playerItemDidFinishPlaying(sender: Notification) {
        
        isPlaying = false

    }

}


