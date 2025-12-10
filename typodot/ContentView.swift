//
//  ContentView.swift
//  typodot
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            switch appState.currentScreen {
            case .home:
                HomeView()
            case .typing:
                TypingView()
            case .result:
                ResultView()
            case .ranking:
                RankingView()
            }
        }
        .frame(minWidth: 800, minHeight: 500)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
