//
//  ChartsView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @StateObject var viewModel: ChartsViewModel

    var body: some View {
        VStack(spacing: 16) {

            // Segmented Control
            Picker("", selection: $viewModel.selectedRange) {
                ForEach(ChartsViewModel.Range.allCases, id: \.self) { range in
                    Text(range.rawValue).tag(range)
                }
            }
            .pickerStyle(.segmented)
            .padding(6)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)

            // Empty State
            if viewModel.chart.isEmpty {
                ContentUnavailableView(
                    "No Data",
                    systemImage: "chart.bar",
                    description: Text("Start tracking time to see analytics")
                )
            } else {

                // Chart
                Chart(viewModel.chart) { item in
                    BarMark(
                        x: .value("Period", item.label),
                        y: .value("Minutes", item.minutes)
                    )
                    .cornerRadius(8)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .blue.opacity(0.6)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .annotation(position: .top) {
                        Text(String(format: "%.0f min", item.minutes))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 260)
                .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Analytics")
    }
}
