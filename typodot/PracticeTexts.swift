//
//  PracticeTexts.swift
//  typodot
//

import Foundation

/// Sample texts for typing practice (embedded as code, no external file needed)
enum PracticeTexts {
    static let texts: [String] = [
        "The quick brown fox jumps over the lazy dog.",
        "Pack my box with five dozen liquor jugs.",
        "How vexingly quick daft zebras jump!",
        "The five boxing wizards jump quickly.",
        "Sphinx of black quartz, judge my vow.",
        "Two driven jocks help fax my big quiz.",
        "The job requires extra pluck and zeal from every young wage earner.",
        "A mad boxer shot a quick, gloved jab to the jaw of his dizzy opponent.",
    ]

    static func random() -> String {
        texts.randomElement() ?? texts[0]
    }
}
