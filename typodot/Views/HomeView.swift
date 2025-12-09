//
//  HomeView.swift
//  typodot
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 40) {
            Text("typodot")
                .font(.system(size: 48, weight: .bold, design: .monospaced))

            Text("Typing Practice")
                .font(.title2)
                .foregroundColor(.secondary)

            Button(action: {
                appState.startPractice(with: PracticeTexts.random())
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
