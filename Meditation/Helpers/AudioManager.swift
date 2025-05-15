//
// AudioManager.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 15/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import AVKit
import Foundation

final class AudioManager: ObservableObject {
  // static let shared = AudioManager()
  var player: AVAudioPlayer?
  @Published private(set) var isPlaying: Bool = false
  @Published private(set) var isLooping: Bool = false
  
  func startPlayer(track: String, isPreview: Bool = false) {
    guard let trackUrl = Bundle.main.url(forResource: track, withExtension: "mp3") else {
      print("Resource not found: \(track)")
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(contentsOf: trackUrl)
      if isPreview {
        player?.prepareToPlay()
      } else {
        player?.play()
        isPlaying = true
      }
    } catch {
      print("Failed to initialized player : \(error.localizedDescription)")
    }
  }
  
  func getTrackDuration(track: String) -> TimeInterval {
    guard let trackUrl = Bundle.main.url(forResource: track, withExtension: "mp3") else {
      print("Resource not found: \(track)")
      return 0
    }
    do {
      let tempPlayer = try AVAudioPlayer(contentsOf: trackUrl)
      return tempPlayer.duration
    } catch {
      print("Failed to load track for duration: \(error.localizedDescription)")
      return 0
    }
  }

  func playPause() {
    guard let player else {
      print("Instance of audio player not found")
      return
    }
    if player.isPlaying {
      player.pause()
      isPlaying = false
    } else {
      player.play()
      isPlaying = true
    }
  }
  
  func stop() {
    guard let player else { return }
    if player.isPlaying {
      player.stop()
      isPlaying = false
      isLooping = false
    }
  }
  
  func toggleLoop() {
    guard let player else { return }
    
    player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0 // -1 means loop infinite; 0 means no loop
    isLooping = player.numberOfLoops != 0
  }
}
