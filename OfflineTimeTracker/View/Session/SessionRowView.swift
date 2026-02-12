//
//  SessionRowView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct SessionRowView: View {
    let session: TimeSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // Start – End (safe)
            Text(timeRangeText)
                .font(.headline)

            // Duration
            Text("Duration: \(formattedDuration)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Notes
            if let notes = session.notes, !notes.isEmpty {
                Text(notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            // Tags
            if !session.tags.isEmpty {
                HStack(spacing: 6) {
                    ForEach(session.tags) { tag in
                        TagPillView(text: tag.name)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
private extension SessionRowView {

    var timeRangeText: String {
        let startText = time(session.startTime)

        guard let end = session.endTime else {
            return "\(startText) – Running"
        }

        return "\(startText) – \(time(end))"
    }

    var formattedDuration: String {
        let totalSeconds = Int(session.duration)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(minutes)m \(seconds)s"
    }

    func time(_ date: Date) -> String {
        date.formatted(date: .omitted, time: .shortened)
    }
}
