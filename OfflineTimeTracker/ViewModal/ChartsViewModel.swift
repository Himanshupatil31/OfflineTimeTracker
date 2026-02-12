//
//  ChartsViewModel.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import Foundation

final class ChartsViewModel: ObservableObject {
    enum Range: String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case tag = "Tag"
    }

    @Published var selectedRange: Range = .day {
        didSet { load() }
    }
    @Published var chart: [ChartDataPoint] = []

    private let repository: TimeSessionRepository
    private let calendar = Calendar.current

    init(repository: TimeSessionRepository) {
        self.repository = repository
        load()
    }

    func load() {
        let sessions = repository.fetchAllSessions()

        switch selectedRange {
        case .day:
            chart = byDay(sessions)
        case .week:
            chart = byWeek(sessions)
        case .month:
            chart = byMonth(sessions)
        case .tag:
            chart = byTag(sessions)
        }
    }
    
    private func byDay(_ sessions: [TimeSession]) -> [ChartDataPoint] {
        Dictionary(grouping: sessions) {
            calendar.startOfDay(for: $0.startTime)
        }
        .map { date, sessions in
            ChartDataPoint(
                label: date.formatted(date: .abbreviated, time: .omitted),
                minutes: sessions.reduce(0) { $0 + $1.duration } / 60
            )
        }
        .sorted { $0.label < $1.label }
    }
    
    private func byWeek(_ sessions: [TimeSession]) -> [ChartDataPoint] {
        Dictionary(grouping: sessions) {
            calendar.dateInterval(of: .weekOfYear, for: $0.startTime)?.start
        }
        .compactMap { start, sessions in
            guard let start else { return nil }

            return ChartDataPoint(
                label: "Week of \(start.formatted(date: .abbreviated, time: .omitted))",
                minutes: sessions.reduce(0) { $0 + $1.duration } / 60
            )
        }
        .sorted { $0.label < $1.label }
    }
    private func byMonth(_ sessions: [TimeSession]) -> [ChartDataPoint] {
        Dictionary(grouping: sessions) {
            calendar.date(from: calendar.dateComponents([.year, .month], from: $0.startTime))
        }
        .compactMap { date, sessions in
            guard let date else { return nil }

            return ChartDataPoint(
                label: date.formatted(.dateTime.month().year()),
                minutes: sessions.reduce(0) { $0 + $1.duration } / 60
            )
        }
        .sorted { $0.label < $1.label }
    }
        private func byTag(_ sessions: [TimeSession]) -> [ChartDataPoint] {
            var dict: [String: TimeInterval] = [:]

            for session in sessions {
                for tag in session.tags {
                    dict[tag.name, default: 0] += session.duration
                }
            }

            return dict.map {
                ChartDataPoint(
                    label: $0.key,
                    minutes: $0.value / 60
                )
            }
            .sorted { $0.minutes > $1.minutes }
        }

}
extension TimeInterval {
        var inMinutes: Double { self / 60 }
    }
