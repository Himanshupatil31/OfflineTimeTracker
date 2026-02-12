//
//  CoreDataSessionRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
import CoreData

final class CoreDataTimeSessionRepository: TimeSessionRepository {
   
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveSession(_ session: TimeSession) {
        let taskRequest = CDTask.fetchRequest()
        taskRequest.predicate =
            NSPredicate(format: "id == %@", session.taskId as CVarArg)

        guard let task = try? context.fetch(taskRequest).first else { return }

        let cd = CDTimeSession(context: context)
        session.apply(to: cd, task: task, context: context)
        save()
    }

    func fetchSessions(for taskId: UUID) -> [TimeSession] {
        let request = CDTimeSession.fetchRequest()
        request.predicate =
            NSPredicate(format: "task.id == %@", taskId as CVarArg)
        request.sortDescriptors = [
            NSSortDescriptor(key: "start", ascending: false)
        ]

        let result = (try? context.fetch(request)) ?? []
        return result.map { $0.toDomain() }
    }

    func fetchSession(by id: UUID) -> TimeSession? {
        let request = CDTimeSession.fetchRequest()
        request.predicate =
            NSPredicate(format: "id == %@", id as CVarArg)

        return try? context.fetch(request).first?.toDomain()
    }
    
    func fetchAllSessions() -> [TimeSession] {
            let request = CDTimeSession.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: "start", ascending: true)
            ]

            let result = (try? context.fetch(request)) ?? []
            return result.map { $0.toDomain() }
        }
    
    private func save() {
        try? context.save()
    }
}
