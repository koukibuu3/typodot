//
//  RecordStore.swift
//  typodot
//

import Foundation
import SwiftData

enum RankingPeriod {
    case daily
    case weekly
}

@MainActor
struct RecordStore {
    /// Save a new practice record
    static func save(
        wpm: Int,
        accuracy: Double,
        elapsedTime: Double,
        characterCount: Int,
        context: ModelContext
    ) {
        let record = PracticeRecord(
            wpm: wpm,
            accuracy: accuracy,
            elapsedTime: elapsedTime,
            characterCount: characterCount
        )
        context.insert(record)
        try? context.save()
    }

    /// Fetch top 10 records for the specified period, sorted by WPM (descending), then accuracy (descending)
    static func fetchRanking(period: RankingPeriod, context: ModelContext) -> [PracticeRecord] {
        let (startDate, endDate) = dateRange(for: period)

        let predicate = #Predicate<PracticeRecord> { record in
            record.date >= startDate && record.date <= endDate
        }

        var descriptor = FetchDescriptor<PracticeRecord>(
            predicate: predicate,
            sortBy: [
                SortDescriptor(\.wpm, order: .reverse),
                SortDescriptor(\.accuracy, order: .reverse)
            ]
        )
        descriptor.fetchLimit = 10

        do {
            return try context.fetch(descriptor)
        } catch {
            print("Failed to fetch ranking: \(error)")
            return []
        }
    }

    /// Calculate date range for the specified period
    private static func dateRange(for period: RankingPeriod) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let now = Date()

        // End of today (23:59:59)
        let startOfToday = calendar.startOfDay(for: now)
        let endOfToday = calendar.date(byAdding: .day, value: 1, to: startOfToday)!.addingTimeInterval(-1)

        switch period {
        case .daily:
            // Today 00:00:00 ~ 23:59:59
            return (startOfToday, endOfToday)

        case .weekly:
            // 7 days ago 00:00:00 ~ Today 23:59:59
            let startOfWeek = calendar.date(byAdding: .day, value: -6, to: startOfToday)!
            return (startOfWeek, endOfToday)
        }
    }
}
