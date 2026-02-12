//
//  TaskRowView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskItem

    var body: some View {
        NavigationLink {
            TaskDetailView(
                viewModel: TimerViewModel(
                    taskId: task.id,
                    taskObjectID: task.objectID,
                    sessionRepository: AppContainer.shared.sessionRepo,
                    tagRepository: AppContainer.shared.tagRepo
                )
            )
        } label: {
            VStack(alignment: .leading, spacing: 8) {

                // TITLE
                Text(task.title)
                    .font(.headline)

                // CREATED DATE
                Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                // TAGS
                if !task.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(task.tags) { tag in
                            Text(tag.name)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(8)
                        }
                    }
                }

              
            }
            .padding(.vertical, 8)
        }
    }
}
