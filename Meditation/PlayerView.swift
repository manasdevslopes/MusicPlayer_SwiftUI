//
// PlayerView.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import ActivityKit
import SwiftUI

struct PlayerView: View {
  @EnvironmentObject var audioManager: AudioManager
  @Environment(\.dismiss) private var dismiss
  var meditation: MeditationModel
  var isPreview: Bool = false
  @State private var isEditing: Bool = false
  @State private var value: Double = 0.0
  @State private var lastActivityUpdate = Date.distantPast
  @State private var tickCount = 0
  @State private var activity: Activity<MusicPlayerAttributes>? = nil
  
  let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Image(meditation.image).resizable().scaledToFill()
        .frame(width: UIScreen.main.bounds.width).ignoresSafeArea()
      
      // MARK: - Blur View
      Rectangle().background(.ultraThinMaterial).opacity(0.68).ignoresSafeArea()
      
      VStack(spacing: 32) {
        // MARK: - Dismiss Button
        HStack {
          Button {
            audioManager.stop()
            stopActivity()
            self.dismiss()
          } label: {
            Image(systemName: "xmark.circle.fill").font(.system(size: 36)).foregroundStyle(.white)
          }
          Spacer()
        }
        // MARK: - Title
        Text(meditation.title).font(.title).foregroundStyle(.white)
        
        Spacer()
        
        VStack(spacing: 5) {
          Slider(value: $value, in: 0...(audioManager.player?.duration ?? 0)) { editing in
            isEditing = editing
            if !editing {
              audioManager.player?.currentTime = value
            }
          }
          .tint(.white)
            
          // MARK: - Playback Time
          if let player = audioManager.player {
            HStack {
              Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "00:00")
              Spacer()
              Text(DateComponentsFormatter.positional.string(from: (player.duration) - (player.currentTime)) ?? "00:00")
            }
            .font(.caption).foregroundStyle(.white)
          }
        }
        
        // MARK: - Playback Control
        HStack {
          // MARK: - Repeat Button
          let color: Color = audioManager.isLooping ? .teal : .white
          PlaybackControlButton(systemName: "repeat", color: color, action: {
            audioManager.toggleLoop()
          })
          Spacer()
          // MARK: - Go Backward Button
          PlaybackControlButton(systemName: "gobackward.10", action: {
            guard let player = audioManager.player else { return }
            player.currentTime = max(player.currentTime - 10, 0)
          })
          .disabled((audioManager.player?.currentTime ?? 0) - 10 < 0)
          Spacer()
          // MARK: - Play / Pause Button
          PlaybackControlButton(
            systemName: (value == 0 ? "play.circle.fill" : (audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")),
            fontSize: 44, action: {
              audioManager.playPause()
            })
          Spacer()
          // MARK: - Go Forward Button
          PlaybackControlButton(systemName: "goforward.10", action: {
            audioManager.player?.currentTime += 10
          })
          .disabled((audioManager.player?.currentTime ?? 0) + 10 >= (audioManager.player?.duration ?? 0))
          Spacer()
          // MARK: - Stop Button
          PlaybackControlButton(systemName: "stop.fill", action: {
            audioManager.stop()
            stopActivity()
            self.dismiss()
          })
        }
      }
      .padding(20)
    }
    .onAppear {
      audioManager.startPlayer(track: meditation.track, isPreview: isPreview)
      // AudioManager.shared.startPlayer(track: meditation.track, isPreview: isPreview)
      startActivity()
    }
    .onReceive(timer) { _ in
      guard let player = audioManager.player, !isEditing else { return }
      self.value = player.currentTime
      updateActivity()
    }
  }
}

#Preview {
  PlayerView(meditation: MeditationModel.data, isPreview: true)
    .environmentObject(AudioManager())
}

extension PlayerView {
  private func startActivity() {
    let attributes = MusicPlayerAttributes(albumArtName: "image-stones")
    let contentState = MusicPlayerAttributes.ContentState(
      title: meditation.title,
      artist: "King",
      elapsedTime: 0,
      duration: audioManager.player?.duration ?? 100
    )
    activity = try? Activity<MusicPlayerAttributes>.request(attributes: attributes, content: .init(state: contentState, staleDate: nil), pushType: nil)
  }
  
  private func updateActivity() {
    guard let activity, let player = audioManager.player else { return }
    let state = MusicPlayerAttributes.ContentState(
      title: meditation.title,
      artist: "King",
      elapsedTime: player.currentTime,
      duration: player.duration
    )
    Task {
      await activity.update(ActivityContent(state: state, staleDate: nil))
    }
  }
  
  private func stopActivity() {
    guard let activity, let player = audioManager.player else { return }
    let state = MusicPlayerAttributes.ContentState(
      title: meditation.title,
      artist: "King",
      elapsedTime: player.currentTime,
      duration: player.duration
    )
    Task {
      await activity.end(ActivityContent(state: state, staleDate: nil), dismissalPolicy: .immediate)
    }
  }
}
