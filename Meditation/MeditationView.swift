//
// MeditationView.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct MeditationView: View {
  @EnvironmentObject var audioManager: AudioManager
  @ObservedObject var meditationVM: MeditationVM
  
  @State private var showPlayer: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      // MARK: - Image
      Image(meditationVM.meditation.image).resizable().scaledToFill()
      //.frame(height: UIScreen.main.bounds.height)
      
      // MARK: - Meditation Details
      ZStack {
        // MARK: - Background
        Color(red: 24/255, green: 23/255, blue: 22/255)
          .frame(height: UIScreen.main.bounds.height * 2 / 4)
        
        VStack(alignment: .leading, spacing: 24) {
          // MARK: - Type & Duration
          VStack(alignment: .leading, spacing: 8) {
            Text("Music")
            Text((DateComponentsFormatter.abbreviated.string(from: audioManager.getTrackDuration(track: "Maan")) ?? meditationVM.meditation.duration.formatted() + "S"))
          }
          .font(.subheadline).textCase(.uppercase).opacity(0.7)
          
          // MARK: - Title
          Text(meditationVM.meditation.title).font(.title)
          
          // MARK: - Play Button
          Button {
            showPlayer = true
          } label: {
            Label("Play", systemImage: "play.fill")
              .font(.headline).foregroundStyle(.black).padding(.vertical, 10).frame(maxWidth: .infinity)
              .background(.white).clipShape(RoundedRectangle(cornerRadius: 20))
          }
          
          
          // MARK: - Description
          Text(meditationVM.meditation.description)
          Spacer()
          
        }
        .foregroundStyle(.white).padding(20)
      }
    }
    .ignoresSafeArea()
    .fullScreenCover(isPresented: $showPlayer) {
      PlayerView(meditation: meditationVM.meditation)
    }
  }
}

#Preview {
  MeditationView(meditationVM: MeditationVM()).environmentObject(AudioManager())
}
