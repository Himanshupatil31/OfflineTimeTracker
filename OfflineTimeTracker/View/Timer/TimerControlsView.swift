//
//  TimerControlsView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TimerControlsView: View {
    let isRunning: Bool
    let onStart: () -> Void
    let onPause: () -> Void
    let onStop: () -> Void
    
    var body: some View {
        HStack(spacing: 24) {
            
            Button {
                onStart()
            } label: {
                Label("Start", systemImage: "play.fill")
            }
            .buttonStyle(.borderedProminent)
            .disabled(isRunning)
            
            Button {
                onPause()
            } label: {
                Label("Pause", systemImage: "pause.fill")
            }
            .buttonStyle(.bordered)
            .disabled(!isRunning)
            
            Button {
                onStop()
            } label: {
                Label("Stop", systemImage: "stop.fill")
            }
            .buttonStyle(.bordered)
        }
    }
}
