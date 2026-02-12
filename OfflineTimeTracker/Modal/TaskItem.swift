//
//  TaskItem.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation
import CoreData

struct TaskItem: Identifiable, Equatable {
    let id: UUID
    let projectId: UUID
    var title: String
    let objectID: NSManagedObjectID
    let createdAt: Date
    var tags: [Tag]

    init(
        id: UUID,
        projectId: UUID,
        title: String,
        objectID: NSManagedObjectID,
        createdAt: Date,
        tags: [Tag] = []
    ) {
        self.id = id
        self.projectId = projectId
        self.title = title
        self.objectID = objectID
        self.createdAt = createdAt
        self.tags = tags
    }
}
