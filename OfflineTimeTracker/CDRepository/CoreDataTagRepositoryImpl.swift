//
//  CoreDataTagRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
import CoreData

final class CoreDataTagRepository: TagRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchTags() -> [Tag] {
        let request = CDTag.fetchRequest()
        let result = (try? context.fetch(request)) ?? []

        // Seed tags if empty
        if result.isEmpty {
            seedDefaultTags()
            return fetchTags()
        }

        return result.map { $0.toDomain() }
    }

    private func seedDefaultTags() {
        let defaults = ["Work", "Deep Focus", "Urgent"]

        defaults.forEach {
            let tag = CDTag(context: context)
            tag.id = UUID()
            tag.name = $0
        }

        try? context.save()
    }
}
