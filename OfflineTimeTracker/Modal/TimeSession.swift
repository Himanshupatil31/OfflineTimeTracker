//
//  TimeSession.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation
import CoreData

struct TimeSession: Identifiable {
    let id: UUID
    let taskId: UUID
    let startTime: Date
    var endTime: Date?
    var notes: String?
    var tags: [Tag]
    
    var duration: TimeInterval {
        (endTime ?? Date()).timeIntervalSince(startTime)
    }
}
