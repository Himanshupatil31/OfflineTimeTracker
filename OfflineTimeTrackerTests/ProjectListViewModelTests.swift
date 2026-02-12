//
//  ProjectListViewModelTests.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//


@testable import OfflineTimeTracker
import XCTest

final class ProjectListViewModelTests: XCTestCase {

    func testProjectSearchByName() {
        let repo = MockProjectRepository()

        repo.addProject(Project(name: "Work Project"))
        repo.addProject(Project(name: "Personal App"))

        let vm = ProjectListViewModel(repository: repo)

        vm.searchText = "Work"

        XCTAssertEqual(vm.filteredProjects.count, 1)
        XCTAssertEqual(vm.filteredProjects.first?.name, "Work Project")
    }
}
