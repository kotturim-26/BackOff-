// AnalyticsView.swift
// BackOff!!!Mobile
// Created by Maanasvi Kotturi on 4/12/25.

import SwiftUI

struct AnalyticsView: View {
    @State private var selectedDate = Date()
    @State private var sleepData: [SleepData] = []

    var body: some View {
        VStack {
            // Evaluator comment: Consider providing a more descriptive label for the date picker.
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .onChange(of: selectedDate) { newDate in
                    // Evaluator comment: Add logic to prevent selection of future dates or dates without data.
                    loadSleepData(for: newDate)
                }

            if sleepData.isEmpty {
                // Evaluator comment: Display a user-friendly message when there's no data.
                Text("No data collected for this day.")
                    .foregroundColor(.gray)
            } else {
                // Evaluator comment: Add descriptive axis labels to the chart for clarity.
                SleepLineChart(data: sleepData)
                    .frame(height: 200)
                    .padding()
            }

            // Evaluator comment: Lines 31-46 contain complex logic; consider adding comments to explain each step.
            VStack(alignment: .leading) {
                Text("Weekly Analytics")
                    .font(.headline)
                    .padding(.top)

                // Evaluator comment: Clarify the definitions of "current" and "last" week.
                let currentWeekData = getWeekData(for: selectedDate)
                let lastWeekData = getWeekData(for: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? Date())

                let currentWeekBackSleep = currentWeekData.reduce(0) { $0 + $1.backSleepMinutes }
                let lastWeekBackSleep = lastWeekData.reduce(0) { $0 + $1.backSleepMinutes }

                // Evaluator comment: Ensure arrays are not empty before performing calculations to avoid errors.
                let percentChange = calculatePercentChange(current: currentWeekBackSleep, previous: lastWeekBackSleep)

                Text("Back Sleep: \(currentWeekBackSleep) mins")
                Text("Change from last week: \(percentChange)%")
            }
            .padding()
        }
        .onAppear {
            loadSleepData(for: selectedDate)
        }
    }

    private func loadSleepData(for date: Date) {
        // Load sleep data for the selected date.
        // Evaluator comment: Implement logic to handle dates with no data.
        sleepData = SleepDataGenerator.generateData(for: date)
    }

    private func getWeekData(for date: Date) -> [SleepData] {
        // Retrieve sleep data for the week of the given date.
        // Evaluator comment: Clarify how the week is defined (e.g., Sunday to Saturday).
        return SleepDataGenerator.generateWeekData(for: date)
    }

    private func calculatePercentChange(current: Int, previous: Int) -> Int {
        // Calculate the percentage change between current and previous values.
        // Evaluator comment: Handle division by zero when previous value is zero.
        guard previous != 0 else { return 0 }
        return Int(((Double(current) - Double(previous)) / Double(previous)) * 100)
    }
}
