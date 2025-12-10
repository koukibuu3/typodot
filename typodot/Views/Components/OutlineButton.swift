//
//  OutlineButton.swift
//  typodot
//

import SwiftUI

struct OutlineButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(color)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .frame(minWidth: 120)
                .background(isHovered ? color.opacity(0.1) : Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 20) {
        OutlineButton(title: "Start", color: .orange) {}
        OutlineButton(title: "Home", color: .secondary) {}
    }
    .padding()
}
