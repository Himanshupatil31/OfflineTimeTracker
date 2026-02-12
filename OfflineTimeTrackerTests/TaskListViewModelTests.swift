//
//  TaskListViewModelTests.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//


@testable import OfflineTimeTracker
import XCTest

final class TaskListViewModelTests: XCTestCase {

    func testAddTaskAndLoad() {
        let projectId = UUID()
        let taskRepo = MockTaskRepository()
        let sessionRepo = MockTimeSessionRepository()

        let vm = TaskListViewModel(
            projectId: projectId,
            repository: taskRepo,
            sessionRepo: sessionRepo
        )

        vm.addTask(title: "Design UI")
        vm.load()

        XCTAssertEqual(vm.tasks.count, 1)
        XCTAssertEqual(vm.tasks.first?.title, "Design UI")
    }
}
