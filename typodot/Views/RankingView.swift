//
//  RankingView.swift
//  typodot
//

import SwiftUI
import SwiftData

struct RankingView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @State private var rankings: [PracticeRecord] = []

    private var title: String {
        switch appState.initialRankingPeriod {
        case .daily:
            return "Daily Ranking"
        case .weekly:
            return "Weekly Ranking"
        }
    }

    var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .font(.system(size: 36, weight: .bold, design: .monospaced))

            // Ranking list
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("#")
                        .frame(width: 40)
                    Text("WPM")
                        .frame(width: 80)
                    Text("Accuracy")
                        .frame(width: 100)
                    Text("Time")
                        .frame(width: 80)
                    Text("Date")
                        .frame(width: 120)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                Divider()

                if rankings.isEmpty {
                    Text("No records yet")
                        .foregroundColor(.secondary)
                        .padding(40)
                } else {
                    ForEach(Array(rankings.enumerated()), id: \.element.id) { index, record in
                        RankingRow(rank: index + 1, record: record)
                        if index < rankings.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(12)
            .frame(maxWidth: 500)

            OutlineButton(title: "Home", color: .secondary) {
                appState.returnToHome()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear {
            loadRankings()
        }
    }

    private func loadRankings() {
        rankings = RecordStore.fetchRanking(period: appState.initialRankingPeriod, context: modelContext)
    }
}

struct RankingRow: View {
    let rank: Int
    let record: PracticeRecord

    var body: some View {
        HStack {
            Text("\(rank)")
                .font(.system(.body, design: .monospaced))
                .fontWeight(rank <= 3 ? .bold : .regular)
                .foregroundColor(rankColor)
                .frame(width: 40)

            Text("\(record.wpm)")
                .font(.system(.body, design: .monospaced))
                .fontWeight(.semibold)
                .frame(width: 80)

            Text(String(format: "%.1f%%", record.accuracy))
                .font(.system(.body, design: .monospaced))
                .frame(width: 100)

            Text(Scoring.formatTime(record.elapsedTime))
                .font(.system(.body, design: .monospaced))
                .frame(width: 80)

            Text(formatDate(record.date))
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
                .frame(width: 120)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    private var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .primary
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    RankingView()
        .environmentObject(AppState())
}
