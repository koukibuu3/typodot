//
//  TypingView.swift
//  typodot
//

import SwiftUI

struct TypingView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 32) {
            // Stats bar
            HStack(spacing: 40) {
                StatItem(label: "WPM", value: "\(appState.wpm)")
                StatItem(label: "Accuracy", value: String(format: "%.1f%%", appState.accuracy))
                StatItem(label: "Time", value: appState.formattedTime)
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)

            // Target text display
            TypingTextView(
                targetText: appState.targetText,
                currentIndex: appState.currentIndex
            )
            .frame(maxWidth: 800)
            .padding()

            // Instructions
            Text("Start typing to begin")
                .foregroundColor(.secondary)
                .opacity(appState.startTime == nil ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct StatItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct TypingTextView: View {
    let targetText: String
    let currentIndex: Int

    var body: some View {
        Text(attributedText)
            .font(.system(size: 24, design: .monospaced))
            .lineSpacing(8)
            .multilineTextAlignment(.leading)
    }

    private var attributedText: AttributedString {
        var result = AttributedString()
        let chars = Array(targetText)

        for (index, char) in chars.enumerated() {
            var attrChar = AttributedString(String(char))

            if index < currentIndex {
                // Already typed
                attrChar.foregroundColor = .green
            } else if index == currentIndex {
                // Current character
                attrChar.backgroundColor = Color.accentColor.opacity(0.3)
                attrChar.foregroundColor = .primary
            } else {
                // Not yet typed
                attrChar.foregroundColor = .secondary
            }

            result += attrChar
        }

        return result
    }
}

#Preview {
    let state = AppState()
    state.startPractice(with: "The quick brown fox jumps over the lazy dog.")
    return TypingView()
        .environmentObject(state)
}
