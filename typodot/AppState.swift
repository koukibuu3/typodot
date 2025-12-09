//
//  AppState.swift
//  typodot
//

import Foundation
import AppKit

enum Screen {
    case home
    case typing
    case result
}

@MainActor
final class AppState: ObservableObject {
    @Published var currentScreen: Screen = .home

    // Typing state
    @Published var targetText: String = ""
    @Published var currentIndex: Int = 0
    @Published var inputHistory: [Bool] = [] // true = correct, false = incorrect

    // Score state
    @Published var correctCount: Int = 0
    @Published var incorrectCount: Int = 0
    @Published var elapsedTime: TimeInterval = 0
    @Published var startTime: Date?

    // Timer
    private var timer: DispatchSourceTimer?

    // Key event handler
    private let keyEventHandler = KeyEventHandler()

    var wpm: Int {
        guard elapsedTime > 0 else { return 0 }
        let minutes = elapsedTime / 60.0
        let words = Double(correctCount) / 5.0
        return Int(words / minutes)
    }

    var accuracy: Double {
        let total = correctCount + incorrectCount
        guard total > 0 else { return 100.0 }
        return (Double(correctCount) / Double(total)) * 100.0
    }

    var isCompleted: Bool {
        currentIndex >= targetText.count && !targetText.isEmpty
    }

    func startPractice(with text: String) {
        targetText = text
        currentIndex = 0
        inputHistory = []
        correctCount = 0
        incorrectCount = 0
        elapsedTime = 0
        startTime = nil
        currentScreen = .typing
        startKeyCapture()
    }

    private func startKeyCapture() {
        keyEventHandler.start { [weak self] character in
            Task { @MainActor in
                self?.handleKeyInput(character)
            }
        }
    }

    private func stopKeyCapture() {
        keyEventHandler.stop()
    }

    func handleKeyInput(_ character: Character) {
        if startTime == nil {
            startTime = Date()
            startTimer()
        }

        guard currentIndex < targetText.count else { return }

        let targetIndex = targetText.index(targetText.startIndex, offsetBy: currentIndex)
        let targetChar = targetText[targetIndex]

        if character == targetChar {
            correctCount += 1
            inputHistory.append(true)
            currentIndex += 1

            if isCompleted {
                stopTimer()
                stopKeyCapture()
                currentScreen = .result
            }
        } else {
            incorrectCount += 1
            inputHistory.append(false)
        }
    }

    func returnToHome() {
        stopTimer()
        stopKeyCapture()
        currentScreen = .home
    }

    private func startTimer() {
        let queue = DispatchQueue(label: "com.typodot.timer", qos: .userInteractive)
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        timer?.setEventHandler { [weak self] in
            Task { @MainActor in
                guard let self = self, let start = self.startTime else { return }
                self.elapsedTime = Date().timeIntervalSince(start)
            }
        }
        timer?.resume()
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
