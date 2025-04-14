import Foundation

// Evaluator comment: Consider adding a brief file header comment explaining this model's role in the app (e.g., used for chart rendering, analytics, etc.)

// Custom data structure for sleep data
struct SleepData: Identifiable {
    let id = UUID()  // Unique ID to conform to Identifiable for use in SwiftUI views
    
    let date: Date  // Date the sleep data was recorded
    
    let totalSleepMinutes: Int  // Total duration of sleep for the night, in minutes
    
    let backSleepMinutes: Int   // Duration of sleep spent on the back (used for posture analytics)
    
    // Evaluator comment: Consider adding computed properties (e.g., offBackSleepMinutes) or validations if needed.
}
