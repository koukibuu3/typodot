//
//  HomeView.swift
//  typodot
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    private let sampleTexts = [
        "The quick brown fox jumps over the lazy dog.",
        "Pack my box with five dozen liquor jugs.",
        "How vexingly quick daft zebras jump!",
    ]

    var body: some View {
        VStack(spacing: 40) {
            Text("typodot")
                .font(.system(size: 48, weight: .bold, design: .monospaced))

            Text("Typing Practice")
                .font(.title2)
                .foregroundColor(.secondary)

            Button(action: {
                let text = sampleTexts.randomElement() ?? sampleTexts[0]
                appState.startPractice(with: text)
            }) {
                Text("Start Practice")
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
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
