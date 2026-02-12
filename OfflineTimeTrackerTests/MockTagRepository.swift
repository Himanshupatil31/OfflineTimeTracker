//
//  MockTagRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//


@testable import OfflineTimeTracker
import Foundation

final class MockTagRepository: TagRepository {

    func fetchTags() -> [Tag] {
        [
            Tag(id: UUID(), name: "Work"),
            Tag(id: UUID(), name: "Deep Focus"),
            Tag(id: UUID(), name: "Urgent")
        ]
    }
}