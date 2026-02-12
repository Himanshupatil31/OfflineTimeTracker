//
//  TimerState.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

struct TimerState: Codable {
    let taskId: UUID
    let startTime: Date
    let elapsedSeconds: Int
    let isRunning: Bool
}
