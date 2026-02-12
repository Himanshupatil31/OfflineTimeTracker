//
//  TagViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

final class TagViewModel: ObservableObject {
    @Published var tags: [Tag] = []
    
    private let repository: TagRepository
    
    init(repository: TagRepository) {
        self.repository = repository
        load()
    }
    
    func load() {
        tags = repository.fetchTags()
    }
}
