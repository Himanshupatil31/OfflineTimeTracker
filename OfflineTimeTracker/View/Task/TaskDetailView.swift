//
//  TaskDetailView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
 
                TimerCircleView(
                                   seconds: viewModel.elapsedSeconds,
                                   progress: Double(viewModel.elapsedSeconds % 60) / 60
                               )
                // NOTES
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes")
                        .font(.headline)
                    
                    TextEditor(text: $viewModel.notes)
                        .frame(height: 120)
                        .padding(8)
                        .background(Color(.secondarySystemBackground)) 
                        .cornerRadius(8)
                }
                
                // TAGS
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tags")
                        .font(.headline)
                    
                    TagPickerView(
                        tags: viewModel.availableTags,
                        selectedTags: $viewModel.selectedTags
                    )
                }
                
                // CONTROLS
                TimerControlsView(
                    isRunning: viewModel.isRunning,
                    onStart: viewModel.start,
                    onPause: viewModel.pause,
                    onStop: viewModel.stop
                )
                NavigationLink {
                    SessionLogView(
                        viewModel: SessionLogViewModel(
                            taskId: viewModel.taskId,
                            repository: viewModel.sessionRepository
                        )
                    )
                } label: {
                    Text("View Sessions")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
            }
            .onAppear {
                viewModel.onScreenAppear()
            }
            .onDisappear {
                viewModel.onScreenDisappear()
            }
          
            .padding()
        }
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
    }
}
