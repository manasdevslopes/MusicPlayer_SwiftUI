//
// MeditationModel.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

struct MeditationModel: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  let duration: TimeInterval
  let track: String
  let image: String
  
  static let data = MeditationModel(title: "1 Minute Relaxing Meditation", description: "Clear your mind and slumber into nothingness. Allocate only a few moments for a quick breather.", duration: 70, track: "Maan", image: "image-stones")
}
