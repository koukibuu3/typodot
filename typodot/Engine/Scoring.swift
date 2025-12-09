//
//  Scoring.swift
//  typodot
//

import Foundation

/// Calculates typing performance metrics
struct Scoring {
    /// Calculate Words Per Minute (WPM)
    /// Uses standard formula: (characters / 5) / minutes
    /// - Parameters:
    ///   - correctCharacters: Number of correctly typed characters
    ///   - elapsedTime: Time elapsed in seconds
    /// - Returns: WPM value
    static func calculateWPM(correctCharacters: Int, elapsedTime: TimeInterval) -> Int {
        guard elapsedTime > 0 else { return 0 }
        let minutes = elapsedTime / 60.0
        let words = Double(correctCharacters) / 5.0
        return Int(words / minutes)
    }

    /// Calculate typing accuracy as a percentage
    /// - Parameters:
    ///   - correctCount: Number of correct inputs
    ///   - incorrectCount: Number of incorrect inputs
    /// - Returns: Accuracy percentage (0-100)
    static func calculateAccuracy(correctCount: Int, incorrectCount: Int) -> Double {
        let total = correctCount + incorrectCount
        guard total > 0 else { return 100.0 }
        return (Double(correctCount) / Double(total)) * 100.0
    }

    /// Format elapsed time as a readable string
    /// - Parameter time: Time interval in seconds
    /// - Returns: Formatted string (e.g., "1:23.4")
    static func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%d:%02d.%d", minutes, seconds, tenths)
    }
}
