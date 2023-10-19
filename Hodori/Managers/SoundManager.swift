//
//  SoundManager.swift
//  Hodori
//
//  Created by Toughie on 10/18/23.
//

import AVFoundation

final class SoundManager: ObservableObject {
    
    enum SoundNames: String {
        case timerEndSound
        case leftMinutesSound
    }
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    func playSound(fileName: SoundNames) {
        guard let soundPath = Bundle.main.path(forResource: fileName.rawValue, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: soundPath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        timer?.invalidate()
    }
    
    func stopSoundAfterDelay(seconds: TimeInterval) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { _ in
            self.stopSound()
        }
    }
}
