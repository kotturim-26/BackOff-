//
//  SleepLineChart.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/12/25.
///
//  Displays a line graph of back sleep time over a user-selected date range.

import SwiftUI
import Charts


//Swift UI that visualizes back sleep minutes using a smoothed line
struct SleepLineChart: View {
    let sleepData: [SleepData]//array of daily sleep records

    var body: some View {
        Chart {
            ForEach(sleepData) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Back Sleep (min)", entry.backSleepMinutes)
                )
                .foregroundStyle(.blue) //line color
                .interpolationMethod(.catmullRom) //makes curve smooth
                .symbol(Circle()) //shape of each data point
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .chartYScale(domain: 0...maxYValue(from: sleepData))
        .frame(height: 300)
        .padding()
    }

    //calculates maximum y value from above for scale, and all to add white space above
    func maxYValue(from data: [SleepData]) -> Int {
        return max(data.map { $0.backSleepMinutes }.max() ?? 30, 30) + 20
    }
}
