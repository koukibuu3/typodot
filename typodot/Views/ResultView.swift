//
//  ResultView.swift
//  typodot
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 40) {
            Text("Results")
                .font(.system(size: 36, weight: .bold, design: .monospaced))

            VStack(spacing: 24) {
                ResultItem(label: "WPM", value: "\(appState.wpm)")
                ResultItem(label: "Accuracy", value: String(format: "%.1f%%", appState.accuracy))
                ResultItem(label: "Time", value: formatTime(appState.elapsedTime))
                ResultItem(label: "Characters", value: "\(appState.correctCount)/\(appState.targetText.count)")
            }
            .padding(32)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(12)

            Button(action: {
                appState.returnToHome()
            }) {
                Text("Back to Home")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%d:%02d.%d", minutes, seconds, tenths)
    }
}

struct ResultItem: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.title2)
                .foregroundColor(.secondary)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
        }
        .frame(width: 280)
    }
}

#Preview {
    let state = AppState()
    state.startPractice(with: "Test")
    state.correctCount = 120
    state.incorrectCount = 5
    state.elapsedTime = 65.3
    return ResultView()
        .environmentObject(state)
}
