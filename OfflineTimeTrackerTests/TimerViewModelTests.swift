//
//  TimerViewModelTests.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//


@testable import OfflineTimeTracker
import XCTest

final class TimerViewModelTests: XCTestCase {

    func testStartAndPauseTimer() {
        let taskId = UUID()
        let sessionRepo = MockTimeSessionRepository()
        let tagRepo = MockTagRepository()

        let vm = TimerViewModel(
            taskId: taskId,
            taskObjectID: .init(),
            sessionRepository: sessionRepo,
            tagRepository: tagRepo
        )

        vm.start()
        XCTAssertTrue(vm.isRunning)

        vm.pause()
        XCTAssertFalse(vm.isRunning)
    }
}