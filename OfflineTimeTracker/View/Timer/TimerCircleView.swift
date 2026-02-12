//
//  TimerCircleView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TimerCircleView: View {
    let seconds: Int
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.2), lineWidth: 12)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    .blue,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)
            
            VStack {
                Text(format(seconds))
                    .font(.system(size: 32, weight: .bold))
                Text("Timer")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 220, height: 220)
    }
    
    private func format(_ seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}
