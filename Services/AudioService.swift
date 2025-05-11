// AudioService.swift
import Foundation
import AVFoundation
import SwiftUI

class AudioService: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    @Published var isMuted: Bool = false
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioService: Не удалось настроить аудиосессию: \(error.localizedDescription)")
        }
    }
    
    func play(audioURL: URL?) {
        guard let url = audioURL else {
            print("AudioService: Отсутствует URL для аудио")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            
            if !isMuted {
                audioPlayer?.play()
                isPlaying = true
            }
        } catch {
            print("AudioService: Не удалось воспроизвести аудио: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    func restart() {
        if let player = audioPlayer {
            player.currentTime = 0
            if !isMuted {
                player.play()
                isPlaying = true
            }
        }
    }
    
    func toggleMute() {
        isMuted.toggle()
        
        if isMuted {
            audioPlayer?.pause()
            isPlaying = false
        } else if let player = audioPlayer {
            player.play()
            isPlaying = true
        }
    }
    
    func handleInterruption() {
        // Обработка прерываний (звонки, уведомления и т.д.)
        stop()
    }
}

// Расширение для обработки завершения проигрывания
extension AudioService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
