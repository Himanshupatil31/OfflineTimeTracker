//
//  GlobalTimerEngine.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//

import Foundation


final class GlobalTimerEngine {

    static let shared = GlobalTimerEngine()
    private init() {}

    private var timer: Timer?
    private var tickHandler: (() -> Void)?

    func start(tick: @escaping () -> Void) {
        stop()
        tickHandler = tick

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            tick()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        tickHandler = nil
    }

    var isRunning: Bool {
        timer != nil
    }
}
