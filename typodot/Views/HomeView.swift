//
//  HomeView.swift
//  typodot
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 40) {
                Text("typo.")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))

                OutlineButton(title: "Start", color: .orange) {
                    appState.startPractice(with: PracticeTexts.random())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Bottom overlay
            VStack {
                Spacer()
                HStack {
                    // Version info (bottom left)
                    Text("v\(appVersion)")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundColor(.secondary.opacity(0.6))
                        .padding(24)

                    Spacer()

                    // Ranking links (bottom right)
                    VStack(alignment: .trailing, spacing: 8) {
                        RankingLink(title: "Daily Ranking") {
                            appState.showRanking(period: .daily)
                        }
                        RankingLink(title: "Weekly Ranking") {
                            appState.showRanking(period: .weekly)
                        }
                    }
                    .padding(24)
                }
            }
        }
    }
}

struct RankingLink: View {
    let title: String
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "trophy")
                    .font(.system(size: 14))
                Text(title)
                    .font(.body)
            }
            .foregroundColor(isHovered ? .orange : .secondary)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
