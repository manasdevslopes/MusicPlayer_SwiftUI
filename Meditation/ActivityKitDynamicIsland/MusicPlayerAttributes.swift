//
// MusicPlayerAttributes.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 22/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import ActivityKit
import SwiftUI

struct MusicPlayerAttributes: ActivityAttributes {
  public typealias MusicPlayerStatus = ContentState
  
  public struct ContentState: Codable, Hashable {
    var title: String
    var artist: String
    var elapsedTime: TimeInterval
    var duration: TimeInterval
  }
  
  var albumArtName: String // Asset name or remote URL
}
