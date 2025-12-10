//
//  AppState.swift
//  typodot
//

import Foundation
import AppKit
import Combine

enum Screen {
    case home
    case typing
    case result
    case ranking
}

@MainActor
final class AppState: ObservableObject {
    @Published var currentScreen: Screen = .home

    // Typing engine
    @Published private(set) var engine: TypingEngine?

    // Timer state
    @Published var elapsedTime: TimeInterval = 0
    @Published var startTime: Date?

    // Error feedback state
    @Published var showErrorFeedback: Bool = false

    // Timer
    private var timer: DispatchSourceTimer?

    // Key event handler
    private let keyEventHandler = KeyEventHandler()

    // Computed properties for UI
    var targetText: String {
        engine?.targetText ?? ""
    }

    var currentIndex: Int {
        engine?.currentIndex ?? 0
    }

    var correctCount: Int {
        engine?.correctCount ?? 0
    }

    var incorrectCount: Int {
        engine?.incorrectCount ?? 0
    }

    var wpm: Int {
        Scoring.calculateWPM(correctCharacters: correctCount, elapsedTime: elapsedTime)
    }

    var accuracy: Double {
        Scoring.calculateAccuracy(correctCount: correctCount, incorrectCount: incorrectCount)
    }

    var isCompleted: Bool {
        engine?.isCompleted ?? false
    }

    var formattedTime: String {
        Scoring.formatTime(elapsedTime)
    }

    func startPractice(with text: String) {
        engine = TypingEngine(targetText: text)
        elapsedTime = 0
        startTime = nil
        currentScreen = .typing
        startKeyCapture()
    }

    private func startKeyCapture() {
        keyEventHandler.start(
            onKeyDown: { [weak self] character in
                Task { @MainActor in
                    self?.handleKeyInput(character)
                }
            },
            onEscape: { [weak self] in
                Task { @MainActor in
                    self?.returnToHome()
                }
            }
        )
    }

    private func stopKeyCapture() {
        keyEventHandler.stop()
    }

    func handleKeyInput(_ character: Character) {
        guard engine != nil else { return }

        if startTime == nil {
            startTime = Date()
            startTimer()
        }

        let wasCorrect = engine?.processInput(character) ?? false

        if !wasCorrect {
            // Show brief error feedback
            showErrorFeedback = true
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 150_000_000) // 150ms
                self.showErrorFeedback = false
            }
        }

        // Force UI update by triggering objectWillChange
        objectWillChange.send()

        if isCompleted {
            stopTimer()
            stopKeyCapture()
            currentScreen = .result
        }
    }

    func returnToHome() {
        stopTimer()
        stopKeyCapture()
        engine = nil
        currentScreen = .home
    }

    func showRanking() {
        currentScreen = .ranking
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
