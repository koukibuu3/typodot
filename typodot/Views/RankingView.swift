//
//  RankingView.swift
//  typodot
//

import SwiftUI
import SwiftData

struct RankingView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @State private var selectedPeriod: RankingPeriod = .daily
    @State private var rankings: [PracticeRecord] = []

    var body: some View {
        VStack(spacing: 32) {
            Text("Ranking")
                .font(.system(size: 36, weight: .bold, design: .monospaced))

            // Period selector
            HStack(spacing: 0) {
                PeriodTab(title: "Daily", isSelected: selectedPeriod == .daily) {
                    selectedPeriod = .daily
                    loadRankings()
                }
                PeriodTab(title: "Weekly", isSelected: selectedPeriod == .weekly) {
                    selectedPeriod = .weekly
                    loadRankings()
                }
            }
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)

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
        rankings = RecordStore.fetchRanking(period: selectedPeriod, context: modelContext)
    }
}

struct PeriodTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .orange : .secondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(isHovered && !isSelected ? Color.secondary.opacity(0.1) : Color.clear)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
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
