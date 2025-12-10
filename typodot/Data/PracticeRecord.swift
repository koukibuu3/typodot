//
//  PracticeRecord.swift
//  typodot
//

import Foundation
import SwiftData

@Model
final class PracticeRecord {
    var id: UUID
    var date: Date
    var wpm: Int
    var accuracy: Double
    var elapsedTime: Double
    var characterCount: Int

    init(wpm: Int, accuracy: Double, elapsedTime: Double, characterCount: Int) {
        self.id = UUID()
        self.date = Date()
        self.wpm = wpm
        self.accuracy = accuracy
        self.elapsedTime = elapsedTime
        self.characterCount = characterCount
    }
}
