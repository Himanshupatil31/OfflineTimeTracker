//
//  ProjectListViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import Foundation

final class ProjectListViewModel: ObservableObject {

    @Published var projects: [Project] = []
    @Published var searchText: String = ""

    private let repository: ProjectRepository

    init(repository: ProjectRepository) {
        self.repository = repository
        load()
    }

    func load() {
        projects = repository.fetchProjects()
    }

   
    var filteredProjects: [Project] {
        guard !searchText.isEmpty else { return projects }
        return projects.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - CRUD

    func addProject(name: String) {
        repository.addProject(Project(id: UUID(), name: name))
        load()
    }

    func renameProject(_ project: Project, newName: String) {
        repository.updateProject(
            Project(id: project.id, name: newName, createdAt: project.createdAt)
        )
        load()
    }

    func deleteProject(_ project: Project) {
        repository.deleteProject(project)
        load()
    }
}
