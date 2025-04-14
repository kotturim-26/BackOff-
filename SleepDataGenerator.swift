//
//  SleepDataGenerator.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 4/13/25.
//
//  Generates dummy sleep data for testing and prototyping analytics views.
//  Each SleepData entry includes a date, total sleep minutes, and back sleep minutes.

import Foundation

struct SleepDataGenerator {
    
    // Generates a list of SleepData objects for the past `days` number of days
    static func generateDummySleepData(days: Int) -> [SleepData] {
        let calendar = Calendar.current
        let today = Date()
        
        return (0..<days).map { i in
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            
            // Random total sleep between 6.5 to ~8.5 hours
            let total = Int.random(in: 400...520)
            
            // Simulate a decreasing back sleep trend over time
            let back = max(0, Int(Double(total) * Double.random(in: 0.1...0.4)) - (i * 2))
            
            return SleepData(date: date, totalSleepMinutes: total, backSleepMinutes: back)
        }
        .reversed() // Evaluator comment: Reversing keeps chronological order from oldest to newest
    }
    
    // Evaluator comment: Consider adding parameter options to simulate different trends or edge cases (e.g., flat patterns, zero back sleep, all-back sleeping)
    // Evaluator comment: Could support seeding for reproducible test results
}
