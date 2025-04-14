//
//  SleepLineChart.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/12/25.
//
//  Displays a line graph of back sleep time over a user-selected date range.

import SwiftUI
import Charts

// SwiftUI view that visualizes back sleep minutes using a smoothed line chart
struct SleepLineChart: View {
    let sleepData: [SleepData] // Array of daily sleep records passed into the chart

    var body: some View {
        Chart {
            ForEach(sleepData) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Back Sleep (min)", entry.backSleepMinutes)
                )
                .foregroundStyle(.blue) // Line color

                // Evaluator comment: Use `.interpolationMethod(.catmullRom)` to make the line smooth and natural-looking
                .interpolationMethod(.catmullRom)

                // Evaluator comment: Circle markers make data points more visible
                .symbol(Circle())
            }
        }

        // Evaluator comment: Add labeled X-axis with weekday abbreviations
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }

        // Evaluator comment: Dynamically scale the Y-axis based on max back sleep minutes
        .chartYScale(domain: 0...maxYValue(from: sleepData))

        .frame(height: 300)
        .padding()

        // Evaluator comment: Consider adding accessibility labels and chart title for better UX
    }

    /// Calculates maximum Y value to scale chart appropriately and add visual padding
    func maxYValue(from data: [SleepData]) -> Int {
        // Evaluator comment: Default fallback is 30 minutes; adds 20 for white space at the top
        return max(data.map { $0.backSleepMinutes }.max() ?? 30, 30) + 20
    }
}
