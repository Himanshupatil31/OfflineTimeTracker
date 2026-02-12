//
//  TimerView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("\(viewModel.elapsedSeconds) sec")
                .font(.largeTitle)
            
            HStack {
                Button("Start", action: viewModel.start)
                Button("Pause", action: viewModel.pause)
                Button("Stop", action: viewModel.stop)
            }
        }
        .padding()
    }
}
