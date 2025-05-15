//
// Extensions.swift
// Meditation
//
// Created by MANAS VIJAYWARGIYA on 15/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

extension DateComponentsFormatter {
  // This pattern is called lazy initialization. It won't be initialised until used.
  // Also static, ensures that there's only one instance of it.
  static let abbreviated: DateComponentsFormatter = {
    print("Initializing DateComponentsFormatter.abbreviated...")
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    return formatter
  }() // Call the method directly.
  
  static let positional: DateComponentsFormatter = {
    print("Initializing DateComponentsFormatter.positional...")
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    return formatter
  }()
}
