//
//  TypingView.swift
//  typodot
//

import SwiftUI

struct TypingView: View {
    @EnvironmentObject var appState: AppState
    @State private var isStatsHidden = false
    @State private var isStatsHovered = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Main content
            VStack(spacing: 32) {
                // Stats bar
                StatsBar(
                    wpm: appState.wpm,
                    accuracy: appState.accuracy,
                    time: appState.formattedTime,
                    isHidden: isStatsHidden,
                    isHovered: $isStatsHovered,
                    onToggle: { isStatsHidden.toggle() }
                )

                // Target text display
                TypingTextView(
                    targetText: appState.targetText,
                    currentIndex: appState.currentIndex,
                    showError: appState.showErrorFeedback
                )
                .frame(maxWidth: 800)
                .padding()

                // Instructions
                Text("Start typing to begin")
                    .foregroundColor(.secondary)
                    .opacity(appState.startTime == nil ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Escape hint
            Text("esc to quit")
                .foregroundColor(.secondary)
                .padding(16)
        }
        .padding()
    }
}

struct StatsBar: View {
    let wpm: Int
    let accuracy: Double
    let time: String
    let isHidden: Bool
    @Binding var isHovered: Bool
    let onToggle: () -> Void

    @State private var isButtonHovered = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Stats content
            HStack(spacing: 40) {
                StatItem(label: "WPM", value: "\(wpm)")
                StatItem(label: "Accuracy", value: String(format: "%.1f%%", accuracy))
                StatItem(label: "Time", value: time)
            }
            .padding()
            .padding(.trailing, 20)
            .opacity(isHidden ? 0 : 1)

            // Toggle button (visible on hover)
            Button(action: onToggle) {
                Image(systemName: isHidden ? "eye" : "eye.slash")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(6)
            }
            .buttonStyle(.plain)
            .opacity(isHovered || isButtonHovered ? 1 : 0)
            .onHover { hovering in
                isButtonHovered = hovering
            }
            .padding(4)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
        .onHover { hovering in
            isHovered = hovering
        }
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
    let showError: Bool

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
                // Already typed correctly
                attrChar.foregroundColor = .green
            } else if index == currentIndex {
                // Current character - show red background on error
                if showError {
                    attrChar.backgroundColor = Color.red.opacity(0.4)
                } else {
                    attrChar.backgroundColor = Color.accentColor.opacity(0.3)
                }
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
