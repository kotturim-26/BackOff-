import Foundation

//Custom data structure for sleepdata
struct SleepData: Identifiable {
    let id = UUID()
    let date: Date
    let totalSleepMinutes: Int
    let backSleepMinutes: Int
}

