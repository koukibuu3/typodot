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
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1)
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
