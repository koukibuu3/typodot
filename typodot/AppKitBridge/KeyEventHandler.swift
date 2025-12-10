//
//  KeyEventHandler.swift
//  typodot
//

import AppKit
import Combine

/// Handles keyboard input using NSEvent.addLocalMonitorForEvents
/// This approach avoids First Responder issues with SwiftUI integration
final class KeyEventHandler {
    private var monitor: Any?
    private var onKeyDown: ((Character) -> Void)?
    private var onEscape: (() -> Void)?

    /// Start monitoring key events
    /// - Parameters:
    ///   - handler: Closure called when a key is pressed
    ///   - onEscape: Closure called when Escape key is pressed
    func start(onKeyDown handler: @escaping (Character) -> Void, onEscape escapeHandler: (() -> Void)? = nil) {
        self.onKeyDown = handler
        self.onEscape = escapeHandler

        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyEvent(event)
            return nil // Consume the event
        }
    }

    /// Stop monitoring key events
    func stop() {
        if let monitor = monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
        }
        onKeyDown = nil
        onEscape = nil
    }

    private func handleKeyEvent(_ event: NSEvent) {
        // Handle Escape key
        if event.keyCode == 53 {
            onEscape?()
            return
        }

        // Ignore modifier-only key presses
        guard !event.modifierFlags.contains(.command),
              !event.modifierFlags.contains(.control),
              !event.modifierFlags.contains(.option) else {
            return
        }

        // Get the characters from the event
        guard let characters = event.characters,
              let character = characters.first else {
            return
        }

        // Only handle printable characters
        if character.isASCII && (character.isLetter || character.isNumber || character.isPunctuation || character.isWhitespace || character.isSymbol) {
            onKeyDown?(character)
        }
    }

    deinit {
        stop()
    }
}
