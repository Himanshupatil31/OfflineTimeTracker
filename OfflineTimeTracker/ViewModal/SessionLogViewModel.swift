//
//  SessionLogViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

final class SessionLogViewModel: ObservableObject {
    @Published var sessions: [TimeSession] = []
    @Published var selectedTag: Tag?
    @Published var selectedDate: Date?

    private let taskId: UUID
     let repository: TimeSessionRepository

    var filteredSessions: [TimeSession] {
           sessions.filter { session in
               let matchesTag =
                   selectedTag == nil || session.tags.contains(selectedTag!)
               
               let matchesDate =
                   selectedDate == nil ||
                   Calendar.current.isDate(session.startTime, inSameDayAs: selectedDate!)
               
               return matchesTag && matchesDate
           }
       }
    init(taskId: UUID, repository: TimeSessionRepository) {
        self.taskId = taskId
        self.repository = repository
        load()
    }

    func load() {
        sessions = repository.fetchSessions(for: taskId)
    }
}
