//
//  TypingEngine.swift
//  typodot
//

import Foundation

/// Handles typing logic: character matching, index progression, and input validation
struct TypingEngine {
    let targetText: String
    private(set) var currentIndex: Int = 0
    private(set) var inputHistory: [InputResult] = []

    enum InputResult {
        case correct
        case incorrect
    }

    var isCompleted: Bool {
        currentIndex >= targetText.count && !targetText.isEmpty
    }

    var correctCount: Int {
        inputHistory.filter { $0 == .correct }.count
    }

    var incorrectCount: Int {
        inputHistory.filter { $0 == .incorrect }.count
    }

    var currentCharacter: Character? {
        guard currentIndex < targetText.count else { return nil }
        let index = targetText.index(targetText.startIndex, offsetBy: currentIndex)
        return targetText[index]
    }

    init(targetText: String) {
        self.targetText = targetText
    }

    /// Process a key input and return whether it was correct
    /// - Parameter character: The character that was typed
    /// - Returns: true if the character was correct, false otherwise
    @discardableResult
    mutating func processInput(_ character: Character) -> Bool {
        guard let target = currentCharacter else { return false }

        if character == target {
            inputHistory.append(.correct)
            currentIndex += 1
            return true
        } else {
            inputHistory.append(.incorrect)
            return false
        }
    }

    /// Reset the engine to initial state
    mutating func reset() {
        currentIndex = 0
        inputHistory = []
    }
}
