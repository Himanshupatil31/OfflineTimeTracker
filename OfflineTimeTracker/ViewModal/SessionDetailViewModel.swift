//
//  SessionDetailViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published private(set) var session: TimeSession?

    private let sessionId: UUID
    private let repository: TimeSessionRepository

    init(sessionId: UUID, repository: TimeSessionRepository) {
        self.sessionId = sessionId
        self.repository = repository
        load()
    }

    func load() {
        session = repository.fetchSession(by: sessionId)
    }
}
extension SessionDetailViewModel {

    var timeRangeText: String {
        guard let session else { return "" }

        let start = format(session.startTime)

        guard let end = session.endTime else {
            return "\(start) – Running"
        }

        return "\(start) – \(format(end))"
    }

    var durationText: String {
        guard let session else { return "" }

        let total = Int(session.duration)
        let m = total / 60
        let s = total % 60
        return "\(m)m \(s)s"
    }

    private func format(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
