//
//  OfflineTimeTrackerApp.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

@main
struct OfflineTimeTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            RootView()
        }
    }
}
