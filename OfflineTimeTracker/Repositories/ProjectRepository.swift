//
//  ProjectRepository.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

protocol ProjectRepository {
    func fetchProjects() -> [Project]
    func addProject(_ project: Project)
    func updateProject(_ project: Project)
    func deleteProject(_ project: Project)
}
