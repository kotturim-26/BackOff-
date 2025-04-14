//
//  StackedSleepChart.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/12/25.
//

import SwiftUI
import Charts

struct StackedSleepBarChart: View {
    let sleepData: [SleepData] // Assumes SleepData has `date`, `backSleepMinutes`, `totalSleepMinutes`

    var body: some View {
        Chart {
            ForEach(sleepData) { entry in
                // Back Sleep Portion
                BarMark(
                    x: .value("Date", entry.date),
                    y: .value("Minutes", entry.backSleepMinutes)
                )
                .foregroundStyle(Color.purple)
                .annotation(position: .top, alignment: .center) {
                    if entry.backSleepMinutes > 0 {
                        Text("\(entry.backSleepMinutes) min")
                            .font(.caption2)
                            .foregroundColor(.purple)
                    }
                }

                // Off-Back Sleep Portion
                BarMark(
                    x: .value("Date", entry.date),
                    y: .value("Minutes", max(entry.totalSleepMinutes - entry.backSleepMinutes, 0))
                )
                .foregroundStyle(Color.blue)
            }
        }
        .chartLegend(position: .top, alignment: .leading)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .chartYScale(domain: 0...maxYValue())
        .frame(height: 300)
        .padding()
    }

    /// Calculates a dynamic Y-axis max value based on the highest total sleep duration
    private func maxYValue() -> Int {
        max(sleepData.map { $0.totalSleepMinutes }.max() ?? 480, 480) + 30
    }
}

