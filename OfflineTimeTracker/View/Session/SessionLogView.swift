//
//  SessionLogView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct SessionLogView: View {
    @StateObject var viewModel: SessionLogViewModel

    var body: some View {
        List {
            ForEach(viewModel.filteredSessions) { session in
                NavigationLink {
                    SessionDetailView(
                        viewModel: SessionDetailViewModel(
                            sessionId: session.id,
                            repository: viewModel.repository
                        )
                    )
                } label: {
                    SessionRowView(session: session)
                }
            }
        }
        .navigationTitle("Sessions")
    }
}
