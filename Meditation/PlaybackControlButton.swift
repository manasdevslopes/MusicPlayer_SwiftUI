//
// PlaybackControlButton.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 14/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct PlaybackControlButton: View {
  var systemName: String = "play"
  var fontSize: CGFloat = 24
  var color: Color = .white
  var action: () -> ()
  
  var body: some View {
    Button(action: action) {
      Image(systemName: systemName).font(.system(size: fontSize)).foregroundStyle(color)
    }
    
  }
}

#Preview {
  PlaybackControlButton(action: { }).preferredColorScheme(.dark)
}
