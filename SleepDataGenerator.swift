//
//  SleepDataGenerator.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/13/25.
////
//  Generates dummy sleep data for testing and prototyping analytics views.
//  Each SleepData entry includes a date, total sleep minutes, and back sleep minutes.

import Foundation

struct SleepDataGenerator {
    static func generateDummySleepData(days: Int) -> [SleepData] {
        let calendar = Calendar.current
        let today = Date()
        return (0..<days).map { i in
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            let total = Int.random(in: 400...520)
            let back = max(0, Int(Double(total) * Double.random(in: 0.1...0.4)) - (i * 2)) // simulate trend
            return SleepData(date: date, totalSleepMinutes: total, backSleepMinutes: back)
        }.reversed()
    }
}
