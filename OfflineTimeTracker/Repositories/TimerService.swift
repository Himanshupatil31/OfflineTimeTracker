//
//  TimerService.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import Foundation
import SwiftUI

final class TimerService {
    private var timer: DispatchSourceTimer?
    private(set) var elapsed: TimeInterval = 0
    var onTick: ((TimeInterval) -> Void)?
    
    func start(from elapsed: TimeInterval = 0) {
        self.elapsed = elapsed
        stop()
        
        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now(), repeating: 1)
        timer.setEventHandler { [weak self] in
            guard let self else { return }
            self.elapsed += 1
            self.onTick?(self.elapsed)
        }
        self.timer = timer
        timer.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
}
