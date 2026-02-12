//
//  TagRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

protocol TagRepository {
    func fetchTags() -> [Tag]
}
