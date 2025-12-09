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
                ResultItem(label: "Time", value: appState.formattedTime)
                ResultItem(label: "Characters", value: "\(appState.correctCount)/\(appState.targetText.count)")
            }
            .padding(32)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(12)

            HStack(spacing: 16) {
                Button(action: {
                    appState.startPractice(with: PracticeTexts.random())
                }) {
                    Text("Try Again")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)

                Button(action: {
                    appState.returnToHome()
                }) {
                    Text("Home")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color(nsColor: .controlBackgroundColor))
                        .foregroundColor(.primary)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    state.startPractice(with: "Test text for preview")
    state.elapsedTime = 65.3
    return ResultView()
        .environmentObject(state)
}
