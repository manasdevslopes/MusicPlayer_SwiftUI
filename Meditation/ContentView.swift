//
// ContentView.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @StateObject var meditationVM: MeditationVM = MeditationVM()
  
  var body: some View {
    MeditationView(meditationVM: MeditationVM())
      .environmentObject(AudioManager())
  }
}

#Preview {
  ContentView()
}
