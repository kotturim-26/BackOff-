//  AnalyticsView.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 3/10/25.

// this file is code for the analytics page of the app
//user can select specific dates to view data and navigate to various graphs
import SwiftUI
import Charts

struct AnalyticsView: View {
    //Active chart allows for user to select dates
    enum ActiveChart {
        case line, bar, none
    }

    @State private var dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let end = Date()
        return start...end
    }()

    @State private var activeChart: ActiveChart = .none
    //Generation of fake data for prototype/testing pursposes will be replaced by data accquired from device later
    private var allSleepData: [SleepData] = SleepDataGenerator.generateDummySleepData(days: 60)
    //filter sleep data to include only selected date range
    private var filteredSleepData: [SleepData] {
        return allSleepData.filter { dateRange.contains($0.date) }
    }

    //calculate percent change in time spent back sleeping from curret week to last week
    private func percentChangeFromLastWeek(current: [SleepData], all: [SleepData]) -> Double {
        let calendar = Calendar.current
        guard let startOfLastWeek = calendar.date(byAdding: .day, value: -7, to: dateRange.lowerBound),
              let endOfLastWeek = calendar.date(byAdding: .day, value: -1, to: dateRange.lowerBound) else { return 0 }

        let lastWeek = all.filter { $0.date >= startOfLastWeek && $0.date <= endOfLastWeek }

        let avgThisRange = current.map { Double($0.backSleepMinutes) }.reduce(0, +) / Double(current.count)
        let avgLastWeek = lastWeek.map { Double($0.backSleepMinutes) }.reduce(0, +) / Double(lastWeek.count)

        guard avgLastWeek > 0 else { return 0 }

        return ((avgThisRange - avgLastWeek) / avgLastWeek) * 100
    }

    var body: some View {
        //allows user to scroll for easier viewing
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                Text("Your Sleep Analytics")
                    .font(.largeTitle)
                    .padding(.top)

                VStack(alignment: .leading) {
                    Text("Select Date Range")
                        .font(.headline)
                    DatePicker("Start", selection: Binding(
                        get: { dateRange.lowerBound },
                        set: { dateRange = $0...dateRange.upperBound }
                    ), displayedComponents: [.date])
                    DatePicker("End", selection: Binding(
                        get: { dateRange.upperBound },
                        set: { dateRange = dateRange.lowerBound...$0 }
                    ), in: dateRange.lowerBound...Date(), displayedComponents: [.date])
                }
                .padding()
//integrating graphs
                HStack(spacing: 16) {
                    Button("Back Sleep Line Chart") {
                        activeChart = .line
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Stacked Bar Chart") {
                        activeChart = .bar
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.bottom)

                switch activeChart {
                case .line:
                    VStack(spacing: 10) {
                        Text("Back Sleep Trend (Line)")
                            .font(.headline)

                        SleepLineChart(sleepData: filteredSleepData)

                        let change = percentChangeFromLastWeek(current: filteredSleepData, all: allSleepData)

                        Text(String(format: "Back sleeping %@ %.1f%% since last week",
                                    change > 0 ? "↑" : "↓",
                                    abs(change)))
                            .font(.subheadline)
                            .foregroundColor(change > 0 ? .red : .green)
                    }
                case .bar:
                    VStack(spacing: 10) {
                        Text("Sleep Distribution (Stacked Bar)")
                            .font(.headline)

                        StackedSleepBarChart(sleepData: filteredSleepData)
                    }
                case .none:
                    Text("Select a graph above to view your sleep data.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Analytics")
    }
}

// MARK: - Preview

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}

