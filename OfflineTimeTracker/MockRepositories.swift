//
//  MockRepositories.swift
//  OfflineTimeTrackerTests
//
//  Created by Himanshu on 03/02/26.
//

import Foundation
@testable import OfflineTimeTracker
import Foundation
import CoreData

final class MockProjectRepository: ProjectRepository {

    private(set) var projects: [Project] = []

    func fetchProjects() -> [Project] {
        projects
    }

    func addProject(_ project: Project) {
        projects.append(project)
    }

    func updateProject(_ project: Project) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects[index] = project
        }
    }

    func deleteProject(_ project: Project) {
        projects.removeAll { $0.id == project.id }
    }
}

final class MockTaskRepository: TaskRepository {
    func updateTaskTags(
           taskObjectID: NSManagedObjectID,
           tags: [Tag]
       ) {
           guard let index = tasks.firstIndex(
               where: { $0.objectID == taskObjectID }
           ) else {
               return
           }

           tasks[index].tags = tags
       }
    

    private(set) var tasks: [TaskItem] = []

    func fetchTasks(for projectId: UUID) -> [TaskItem] {
        tasks.filter { $0.projectId == projectId }
    }

    func fetchAllTasks() -> [TaskItem] {
        tasks
    }

    func addTask(title: String, projectId: UUID, createdAt: Date) {
        tasks.append(
            TaskItem(
                id: UUID(),
                projectId: projectId,
                title: title,
                objectID: .init(),
                createdAt: createdAt
            )
        )
    }

    func deleteAllTasks(for projectId: UUID) {
        tasks.removeAll { $0.projectId == projectId }
    }
}

final class MockTimeSessionRepository: TimeSessionRepository {
    func saveSession(_ session: TimeSession) {}
    func fetchSessions(for taskId: UUID) -> [TimeSession] { [] }
    func fetchSession(by id: UUID) -> TimeSession? { nil }
    func fetchAllSessions() -> [TimeSession] { [] }
}
