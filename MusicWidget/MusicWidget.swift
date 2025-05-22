//
// MusicWidget.swift
// MusicWidget
//
// Created by MANAS VIJAYWARGIYA on 22/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import ActivityKit
import SwiftUI
import WidgetKit

struct MusicWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: MusicPlayerAttributes.self) { context in
      // Lock screen / Notification center UI
      VStack(alignment: .leading) {
        HStack {
          Image(context.attributes.albumArtName).resizable().scaledToFit().frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 8))
          VStack(alignment: .leading) {
            Text(context.state.title).bold()
            Text(context.state.artist).font(.caption)
          }
          Spacer()
        }
        ProgressView(value: context.state.elapsedTime, total: context.state.duration)
      }
      .padding()
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Image(context.attributes.albumArtName).resizable().scaledToFit().frame(width: 32, height: 32)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        DynamicIslandExpandedRegion(.center) {
          VStack {
            Text(context.state.title).bold()
            Text(context.state.artist).font(.caption2)
            Text(context.attributes.albumArtName).font(.caption)
          }
        }
        DynamicIslandExpandedRegion(.bottom) {
          ProgressView(value: context.state.elapsedTime / context.state.duration).progressViewStyle(LinearProgressViewStyle()).frame(height: 8)
        }
        DynamicIslandExpandedRegion(.trailing) {
          Image(systemName: "music.note")
        }
      } compactLeading: {
        Image(systemName: "music.note")
      } compactTrailing: {
        Text(context.state.title.prefix(3))
      } minimal: {
        Image(systemName: "music.note")
      }

    }
  }
}
