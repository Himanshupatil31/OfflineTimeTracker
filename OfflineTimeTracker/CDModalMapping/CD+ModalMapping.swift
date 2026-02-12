//
//  CD+ModalMapping.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation
import CoreData

extension CDProject {
    func toDomain() -> Project {
        Project(
            id: id ?? UUID(),
            name: name ?? "",
            createdAt: createdAt ?? Date()
        )
    }
}
extension Project {
    func apply(to cd: CDProject) {
        cd.id = id
        cd.name = name
        cd.createdAt = createdAt
    }
}

extension CDTag {
    func toDomain() -> Tag {
        Tag(
            id: id ?? UUID(),
            name: name ?? ""
        )
    }
}
extension Tag {
    func apply(to cd: CDTag) {
        cd.id = id
        cd.name = name
    }
}
extension CDTask {
    func toDomain() -> TaskItem {
           TaskItem(
               id: id!,
               projectId: project!.id!,
               title: title ?? "",
               objectID: objectID,
               createdAt: createdAt ?? Date(),
               tags: (tags as? Set<CDTag> ?? []).map { $0.toDomain() }
           )
       }
}
extension TaskItem {
    func apply(
        to cd: CDTask,
        project: CDProject
    ) {
        cd.id = id
        cd.title = title
        cd.project = project
        cd.createdAt = createdAt
        
    }
}
extension CDTimeSession {
    func toDomain() -> TimeSession {
        TimeSession(
            id: id ?? UUID(),
            taskId: task?.id ?? UUID(),
            startTime: start ?? Date(),
            endTime: end,
            notes: notes,
            tags: (tags as? Set<CDTag>)?
                .map { $0.toDomain() } ?? []
        )
    }
}
extension TimeSession {
    func apply(
        to cd: CDTimeSession,
        task: CDTask,
        context: NSManagedObjectContext
    ) {
        cd.id = id
        cd.start = startTime
        cd.end = endTime
        cd.notes = notes
        cd.task = task

        let cdTags = tags.map { tag -> CDTag in
            let request = CDTag.fetchRequest()
            request.predicate =
                NSPredicate(format: "id == %@", tag.id as CVarArg)

            if let existing = try? context.fetch(request).first {
                return existing
            } else {
                let new = CDTag(context: context)
                tag.apply(to: new)
                return new
            }
        }

        cd.tags = NSSet(array: cdTags)
    }
}
