//
//  TaskRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation
import CoreData

protocol TaskRepository {
    func fetchTasks(for projectId: UUID) -> [TaskItem]
    func addTask(title: String, projectId: UUID,createdAt:Date)
    func fetchAllTasks() -> [TaskItem]
    func updateTaskTags(taskObjectID: NSManagedObjectID, tags: [Tag])
}
