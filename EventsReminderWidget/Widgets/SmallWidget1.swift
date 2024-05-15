//
//  SmallWidget1.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI
import WidgetKit

struct SmallWidget1: View {
    
    // Builder
    var entry: SimpleEntry
    
    // MARK: -
    var body: some View {
        if let event = entry.event {
            VStack(spacing: 32) {
                VStack(spacing: -4) {
                    Text(event.daysRemaining.formatted())
                        .font(.system(size: 40, weight: .bold))
                    Text("days remaining")
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
                        .fill(event.tag?.color.toColor().opacity(0.3) ?? Color.backgroundComponent)
                    
                    ContainerRelativeShape()
                        .stroke(event.tag?.color.toColor() ?? Color.componentInComponent, lineWidth: 6)
                }
            }
        } else {
            Text("Fail to get an event")
        }
    } // End body
} // End struct
