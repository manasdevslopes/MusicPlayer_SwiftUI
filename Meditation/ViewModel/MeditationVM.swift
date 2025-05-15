//
// MeditationVM.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 15/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

final class MeditationVM: ObservableObject {
  @Published var meditation: MeditationModel
  private let audioManager: AudioManager
  
  init(audioManager: AudioManager = AudioManager()) {
    self.audioManager = audioManager
    let track = Bundle.main.path(forResource: "Maan", ofType: "mp3") ?? ""
    let duration = audioManager.getTrackDuration(track: track)
    self.meditation = MeditationModel(title: "1 Minute Relaxing Meditation", description: "Clear your mind and slumber into nothingness. Allocate only a few moments for a quick breather.", duration: duration, track: "Maan", image: "image-stones")
  }
}
