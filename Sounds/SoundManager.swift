import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    static var playEffect: Bool = false
    var musicPlayer: AVAudioPlayer?
    var effectPlayer: AVAudioPlayer?
    func playMusic() {
        
        guard let url = Bundle.main.url(forResource: "freeMusic", withExtension: ".mp3") else { return }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.volume = 0.1
            musicPlayer?.play()
            musicPlayer?.numberOfLoops = -1
        }catch let error {
            print("Error playig sound. \(error.localizedDescription)")
        }
    }
    
    func stopMusic() {
        musicPlayer?.stop()
    }
    
    func playEffect(of effect: Effect, play: Bool = SoundManager.playEffect) {
        guard let url = Bundle.main.url(forResource: "\(effect)", withExtension: ".mp3") else { return }
        
        do {
            if play {
                effectPlayer = try AVAudioPlayer(contentsOf: url)
                effectPlayer?.play()
            }
        }catch let error {
            print("Error playig sound. \(error.localizedDescription)")
        }
    }
}

enum Effect: String {
    case buttonClick = "buttonClick"
    case cardFlip = "cardFlip"
    case cardDealing = "cardDealing"
}
