//
//  TimerViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import Foundation
import CoreData


final class TimerViewModel: ObservableObject {

    @Published var elapsedSeconds = 0
    @Published var isRunning = false
    @Published var notes = ""
    @Published var selectedTags: Set<Tag> = []
    @Published var availableTags: [Tag] = []

     let taskId: UUID
     let sessionRepository: TimeSessionRepository
     private var wasRunningBeforeExit = false
    let taskObjectID: NSManagedObjectID

    private let timer = GlobalTimerEngine.shared
    private var startTime: Date?

    init(
        taskId: UUID,
        taskObjectID: NSManagedObjectID,
        sessionRepository: TimeSessionRepository,
        tagRepository: TagRepository
    ) {
        self.taskId = taskId
        self.taskObjectID = taskObjectID
        self.sessionRepository = sessionRepository
        self.availableTags = tagRepository.fetchTags()
        restoreTimerIfNeeded()
    }

    func start() {
        guard !isRunning else { return }

        isRunning = true
        startTime = Date()
        startTimer()
        persistTimer()
    }

    func pause() {
        stopTimer()
        isRunning = false
        persistTimer()
    }

    func stop() {
        guard let startTime else { return }

        stopTimer()
        isRunning = false

        let session = TimeSession(
            id: UUID(),
            taskId: taskId,
            startTime: startTime,
            endTime: Date(),
            notes: notes,
            tags: Array(selectedTags)
        )

        sessionRepository.saveSession(session)
        AppContainer.shared.taskRepo.updateTaskTags(
                taskObjectID: taskObjectID,
                tags: Array(selectedTags)
            )
        TimerPersistence.clear()
        reset()
    }
  

    // MARK: - Timer helpers

    private func startTimer() {
        guard !timer.isRunning else { return }

        timer.start { [weak self] in
            self?.elapsedSeconds += 1
            self?.persistTimer()
        }
    }

    private func stopTimer() {
        timer.stop()
    }
    // MARK: - Persistence

    private func persistTimer() {
        guard let startTime else { return }

        let state = TimerState(
            taskId: taskId,
            startTime: startTime,
            elapsedSeconds: elapsedSeconds,
            isRunning: isRunning
        )

        TimerPersistence.save(state)
    }


    private func restoreTimerIfNeeded() {
        guard let state = TimerPersistence.load(),
              state.taskId == taskId else { return }

        elapsedSeconds = state.elapsedSeconds
        isRunning = state.isRunning
        
            ///It gives stop a invalidating state
        startTime = Date().addingTimeInterval(-Double(elapsedSeconds))

        if state.isRunning {
            startTimer()   // safe now
        }
    }
    
    private func reset() {
        elapsedSeconds = 0
        startTime = nil
        notes = ""
        selectedTags.removeAll()
        isRunning = false
    }
    func onScreenDisappear() {
        let state = TimerState(
            taskId: taskId,
            startTime: startTime ?? Date(),
            elapsedSeconds: elapsedSeconds,
            isRunning: isRunning
        )

        stopTimer()
        TimerPersistence.save(state)
    }

    func onScreenAppear() {
        if isRunning {
            startTimer()
        }
    }
}

