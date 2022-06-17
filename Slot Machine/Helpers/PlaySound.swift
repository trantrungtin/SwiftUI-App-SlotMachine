//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Tin Tran on 17/06/2022.
//

import Foundation
import AVFoundation

private var audioPlayer: AVAudioPlayer?

private func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Error: could not find and play the sound file!")
        }
    }
}

func stopSound() {
    audioPlayer?.stop()
}

enum SoundFile: String {
    case spin = "spin"
    case win = "win"
    case high_score = "high-score"
    case casino_chip = "casino-chips"
    case game_over = "game-over"
    case chimeup = "chimeup"
    case riseup = "riseup"
    case background = "background-music"
}

func playSoundFile(_ file: SoundFile) {
    playSound(sound: file.rawValue, type: "mp3")
}
