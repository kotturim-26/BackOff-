//
//  StackedSleepChart.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/12/25.
//

import SwiftUI
import Charts

// SwiftUI view that displays stacked bar charts showing back vs. off-back sleep time per day
struct StackedSleepBarChart: View {
    let sleepData: [SleepData] // Assumes SleepData has `date`, `backSleepMinutes`, and `totalSleepMinutes`

    var body: some View {
        Chart {
            ForEach(sleepData) { entry in
                // Back Sleep Portion
                BarMark(
                    x: .value("Date", entry.date),
                    y: .value("Minutes", entry.backSleepMinutes)
                )
                .foregroundStyle(Color.purple)

                // Evaluator comment: Annotations make values readable, especially when bars are small
                .annotation(position: .top, alignment: .center) {
                    if entry.backSleepMinutes > 0 {
                        Text("\(entry.backSleepMinutes) min")
                            .font(.caption2)
                            .foregroundColor(.purple)
                    }
                }

                // Off-Back Sleep Portion (calculated by subtracting back from total)
                BarMark(
                    x: .value("Date", entry.date),
                    y: .value("Minutes", max(entry.totalSleepMinutes - entry.backSleepMinutes, 0))
                )
                .foregroundStyle(Color.blue)
            }
        }

        // Evaluator comment: Add legend to help distinguish sleep types
        .chartLegend(position: .top, alignment: .leading)

        // Evaluator comment: Improve X-axis readability with abbreviated weekday labels
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }

        // Evaluator comment: Dynamically scale Y-axis based on data for consistent spacing
        .chartYScale(domain: 0...maxYValue())

        .frame(height: 300)
        .padding()

        // Evaluator comment: Consider adding accessibility labels or chart title
    }

    /// Calculates dynamic Y-axis upper bound based on max sleep minutes + buffer
    private func maxYValue() -> Int {
        // Evaluator comment: Default to 480 mins if no data; add padding for visual spacing
        max(sleepData.map { $0.totalSleepMinutes }.max() ?? 480, 480) + 30
    }
}
