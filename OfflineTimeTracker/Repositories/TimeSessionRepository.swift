//
//  TimeSessionRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

protocol TimeSessionRepository {
    func saveSession(_ session: TimeSession)
    func fetchSessions(for taskId: UUID) -> [TimeSession]
    func fetchSession(by id: UUID) -> TimeSession?
    func fetchAllSessions() -> [TimeSession]

}
