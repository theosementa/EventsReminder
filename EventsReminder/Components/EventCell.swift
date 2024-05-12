//
//  EventCell.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI

struct EventCell: View {
    
    // Builder
    @ObservedObject var event: EventEntity
    
    // MARK: -
    var body: some View {
        HStack(spacing: 12) {
            Text(event.emoji)
                .font(.system(size: 24, weight: .bold))
                .frame(width: 28, height: 28)
                .backgroundComponent(isInSheet: true)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(event.name)
                    .font(.system(size: 18, weight: .semibold))
                    .lineLimit(1)
                Text(event.fullDate)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(2)
                    .foregroundStyle(Color(uiColor: .placeholderText))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(event.daysRemaining.formatted())
                .foregroundStyle(event.tag?.color ?? Color(uiColor: .label))
                .font(.system(size: 24, weight: .bold))
                .frame(minWidth: 28)
                .frame(height: 28)
                .backgroundComponent(
                    containerColor: event.tag?.color.opacity(0.3) ?? nil,
                    strokeColor: event.tag?.color ?? nil
                )
        }
        .backgroundComponent()
    } // End body
} // End struct

// MARK: - Preview
#Preview("Dark mode", traits: .sizeThatFitsLayout) {
    EventCell(event: .preview1)
        .preferredColorScheme(.dark)
        .padding()
}

#Preview("Light mode", traits: .sizeThatFitsLayout) {
    EventCell(event: .preview1)
        .padding()
}
