//
//  TaskListViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import Foundation

final class TaskListViewModel: ObservableObject {

    @Published var tasks: [TaskItem] = []
    @Published var searchText: String = ""
    @Published var selectedTags: [Tag] = []
    @Published var dateRange: DateInterval?

    private let projectId: UUID
    private let repository: TaskRepository
    private let sessionRepo: TimeSessionRepository

    init(
        projectId: UUID,
        repository: TaskRepository,
        sessionRepo: TimeSessionRepository
    ) {
        self.projectId = projectId
        self.repository = repository
        self.sessionRepo = sessionRepo
        load()
    }

    var filteredTasks: [TaskItem] {
        tasks.filter { task in
            matchesName(task) && matchesTags(task)
        }
    }

    private func matchesName(_ task: TaskItem) -> Bool {
        searchText.isEmpty ||
        task.title.localizedCaseInsensitiveContains(searchText)
    }

    private func matchesTags(_ task: TaskItem) -> Bool {
        selectedTags.isEmpty ||
        !Set(task.tags.map(\.id))
            .isDisjoint(with: selectedTags.map(\.id))
    }
    func load() {
        tasks = repository.fetchTasks(for: projectId)
        
    }

    func addTask(title: String) {
        repository.addTask(
            title: title,
            projectId: projectId,
            createdAt: Date()
        )
        load()
    }

    
}
