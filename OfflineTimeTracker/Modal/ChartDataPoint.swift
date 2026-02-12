//
//  TimeBucket.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 03/02/26.
//

import Foundation

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let minutes: Double
}
