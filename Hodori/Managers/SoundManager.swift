//
//  SoundManager.swift
//  Hodori
//
//  Created by Yujin Son on 2023/11/14.
//

import SwiftUI
import AVKit


class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "loud-alarm-clock", withExtension: ".mp3") else {return}
        
        do {
        player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
            
        }
    }
    func stopSound() {
            // Stop AVAudioPlayer
        player?.stop()
        }
}

//struct SoundManager_Previews: PreviewProvider {
//    static var previews: some View {
//        SoundManager()
//    }
//}
