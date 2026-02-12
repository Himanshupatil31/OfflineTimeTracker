//
//  SessionDetailView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct SessionDetailView: View {
    @StateObject var viewModel: SessionDetailViewModel

    var body: some View {
        Group {
            if let session = viewModel.session {
                content(session)
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Session Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func content(_ session: TimeSession) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text(viewModel.timeRangeText)
                    .font(.title2)
                    .bold()

                Text("Duration: \(viewModel.durationText)")
                    .foregroundStyle(.secondary)

                Divider()

                if let notes = session.notes, !notes.isEmpty {
                    Text("Notes")
                        .font(.headline)

                    Text(notes)
                }

                if !session.tags.isEmpty {
                    Text("Tags")
                        .font(.headline)

                    HStack {
                        ForEach(session.tags) { tag in
                            TagPillView(text: tag.name)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
