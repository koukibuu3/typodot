//
//  typodotApp.swift
//  typodot
//

import SwiftUI
import SwiftData

@main
struct typodotApp: App {
    @StateObject private var appState = AppState()
    @Environment(\.openWindow) private var openWindow

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PracticeRecord.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .modelContainer(sharedModelContainer)
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 900, height: 600)

        MenuBarExtra {
            Button("typo. を開く") {
                NSApplication.shared.activate(ignoringOtherApps: true)
                if NSApplication.shared.windows.filter({ $0.isVisible }).isEmpty {
                    NSApplication.shared.windows.first?.makeKeyAndOrderFront(nil)
                }
            }
            .keyboardShortcut("o")
            Divider()
            Button("終了") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Image("MenuBarIcon")
        }
    }
}
