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

            VStack(spacing: 16) {
                OutlineButton(title: "Start", color: .orange) {
                    appState.startPractice(with: PracticeTexts.random())
                }

                OutlineButton(title: "Ranking", color: .secondary) {
                    appState.showRanking()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
