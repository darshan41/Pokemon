//
//  PokeCryManager.swift
//  Pokemon
//
//  Created by Darshan S on 20/02/24.
//

import Foundation
import MobileVLCKit

class PokeCryManager {
    
    private let mediaPlayer = VLCMediaPlayer()
    
    init() { }
    
    func play(with url: URL?) {
        guard let url,url.pathExtension == "ogg" else { return }
        mediaPlayer.media = VLCMedia(url: url)
        play()
    }
    
    func togglePlayerState() {
        if mediaPlayer.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        self.mediaPlayer.play()
    }
    
    func stop() {
        self.mediaPlayer.stop()
    }
    
    func pause() {
        self.mediaPlayer.pause()
    }
}
