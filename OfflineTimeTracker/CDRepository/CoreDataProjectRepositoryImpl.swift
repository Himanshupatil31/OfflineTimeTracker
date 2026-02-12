//
//  CoreDataProjectRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
import CoreData

final class CoreDataProjectRepository: ProjectRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchProjects() -> [Project] {
        let request = CDProject.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]

        let result = (try? context.fetch(request)) ?? []
        return result.map { $0.toDomain() }
    }

    func addProject(_ project: Project) {
        let cd = CDProject(context: context)
        project.apply(to: cd)
        save()
    }

    func updateProject(_ project: Project) {
        let request = CDProject.fetchRequest()
        request.predicate =
            NSPredicate(format: "id == %@", project.id as CVarArg)

        guard let cd = try? context.fetch(request).first else { return }
        project.apply(to: cd)
        save()
    }
    func deleteProject(_ project: Project) {
        let request = CDProject.fetchRequest()
        request.predicate = NSPredicate(
            format: "id == %@",
            project.id as CVarArg
        )

        guard let cdProject = try? context.fetch(request).first else {
            return
        }

        context.delete(cdProject)
        save()
    }
    private func save() {
        try? context.save()
    }
}
