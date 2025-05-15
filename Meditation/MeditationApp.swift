//
// MeditationApp.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct MeditationApp: App {
  @StateObject private var audioManager = AudioManager()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(audioManager)
    }
  }
}
