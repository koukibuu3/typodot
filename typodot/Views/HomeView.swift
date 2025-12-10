//
//  HomeView.swift
//  typodot
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 40) {
            Text("typo.")
                .font(.system(size: 48, weight: .bold, design: .monospaced))

            Button(action: {
                appState.startPractice(with: PracticeTexts.random())
            }) {
                Text("Start")
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color(nsColor: .controlBackgroundColor))
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
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
