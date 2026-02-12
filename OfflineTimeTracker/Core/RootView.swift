//
//  RootView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//

import SwiftUI


struct RootView: View {
    var body: some View {
        TabView {
            ProjectListView(
                viewModel: ProjectListViewModel(
                    repository: AppContainer.shared.projectRepo
                )
            )
            .tabItem {
                Label("Projects", systemImage: "folder")
            }

            NavigationStack {
                ChartsView(
                    viewModel: ChartsViewModel(
                        repository: AppContainer.shared.sessionRepo
                    )
                )
            }
            .tabItem {
                Label("Chart", systemImage: "chart.bar")
            }
        }
    }
}
