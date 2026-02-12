//
//  ProjectRowView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct ProjectRowView: View {
    let project: Project

    var body: some View {
        NavigationLink {
            TaskListView(
                viewModel: TaskListViewModel(
                    projectId: project.id,
                    repository: AppContainer.shared.taskRepo,
                    sessionRepo: AppContainer.shared.sessionRepo
                )
            )
        } label: {
            HStack(spacing: 12) {

                Image(systemName: "folder.fill")
                    .foregroundStyle(.blue)

                VStack(alignment: .leading, spacing: 4) {
                    // Project Name
                    Text(project.name)
                        .font(.headline)

                    // Created Date
                    Text(project.createdAt.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}
