//
//  SmallWidget1.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI

struct SmallWidget1: View {
    
    // Builder
    var entry: IntentEntry
    
    // MARK: -
    var body: some View {
        if let event = entry.event {
            VStack(spacing: 32) {
                VStack(spacing: -4) {
                    Text(event.daysRemaining.formatted())
                        .font(.system(size: 40, weight: .bold))
                    Text("word_days_remaining".localized)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text(event.name)
                    .lineLimit(2)
                    .font(.system(size: 14, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
            .background {
                ZStack {
                    Rectangle()
                        .fill(event.tag?.color.toColor().opacity(0.3) ?? Color.Apple.backgroundComponent)
                    
                    ContainerRelativeShape()
                        .stroke(event.tag?.color.toColor() ?? Color.Apple.componentInComponent, lineWidth: 6)
                }
            }
        } else {
            Text("widget_error_get_event".localized)
                .multilineTextAlignment(.center)
                .padding()
        }
    } // End body
} // End struct
