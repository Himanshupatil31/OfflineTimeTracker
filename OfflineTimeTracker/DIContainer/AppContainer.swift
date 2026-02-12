//
//  AppContainer.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


final class AppContainer {
    static let shared = AppContainer()

    let context = PersistenceController.shared.container.viewContext

    lazy var projectRepo = CoreDataProjectRepository(context: context)
    lazy var taskRepo = CoreDataTaskRepository(context: context)
    lazy var tagRepo = CoreDataTagRepository(context: context)
    lazy var sessionRepo = CoreDataTimeSessionRepository(context: context)
}
