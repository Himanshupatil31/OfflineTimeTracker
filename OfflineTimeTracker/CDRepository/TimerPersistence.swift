//
//  TimerPersistence.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
 
struct TimerPersistence {
    private static let key = "running_timer"

    static func save(_ state: TimerState) {
        let data = try? JSONEncoder().encode(state)
        UserDefaults.standard.set(data, forKey: key)
    }

    static func load() -> TimerState? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(TimerState.self, from: data)
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
