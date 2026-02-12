//
//  CoreDataTaskRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
import CoreData

final class CoreDataTaskRepository: TaskRepository {
  
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchTasks(for projectId: UUID) -> [TaskItem] {
        let request = CDTask.fetchRequest()
        request.predicate =
            NSPredicate(format: "project.id == %@", projectId as CVarArg)

        let result = (try? context.fetch(request)) ?? []
        return result.map { $0.toDomain() }
    }

    func addTask(title: String, projectId: UUID, createdAt: Date) {
           let projectRequest = CDProject.fetchRequest()
           projectRequest.predicate =
               NSPredicate(format: "id == %@", projectId as CVarArg)

           guard let project = try? context.fetch(projectRequest).first else { return }

           let cdTask = CDTask(context: context)
           cdTask.id = UUID()
           cdTask.title = title
           cdTask.createdAt = createdAt
           cdTask.project = project

           save()
       }
    func fetchAllTasks() -> [TaskItem] {
          let request = CDTask.fetchRequest()
          let result = (try? context.fetch(request)) ?? []
          return result.map { $0.toDomain() }
      }
    
    func updateTaskTags(
        taskObjectID: NSManagedObjectID,
        tags: [Tag]
    ) {
        guard let task = try? context.existingObject(
            with: taskObjectID
        ) as? CDTask else { return }

        let cdTags: [CDTag] = tags.map { tag in
            let request = CDTag.fetchRequest()
            request.predicate =
                NSPredicate(format: "id == %@", tag.id as CVarArg)

            if let existing = try? context.fetch(request).first {
                return existing
            }

            let new = CDTag(context: context)
            new.id = tag.id
            new.name = tag.name
            return new
        }

        task.tags = NSSet(array: cdTags)
        try? context.save()
    }
    private func save() {
        try? context.save()
    }
}










