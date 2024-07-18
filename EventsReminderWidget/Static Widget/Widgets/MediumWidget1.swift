//
//  MediumWidget1.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI

struct MediumWidget1: View {
    
    // Builder
    var events: [EventEntity]
    
    // MARK: -
    var body: some View {
        if !events.isEmpty {
            VStack(spacing: 16) {
                ForEach(events) { event in
                    HStack(spacing: 12) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(event.tag?.color.toColor().opacity(0.3) ?? Color.Apple.backgroundComponent)
                            
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(event.tag?.color.toColor() ?? Color.Apple.componentInComponent, lineWidth: 2)
                            
                            Text(event.daysRemaining.formatted())
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(event.tag?.color.toColor() ?? Color(uiColor: .label))
                        }
                        .frame(minWidth: 48)
                        .frame(height: 48)
                        .scaledToFit()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.name)
                                .lineLimit(1)
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text(event.fullDate)
                                .lineLimit(1)
                                .foregroundStyle(Color(uiColor: .lightGray))
                                .font(.system(size: 12, weight: .medium))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(24)
            .padding(.horizontal, 4)
            .background {
                ZStack {
                    Rectangle()
                        .fill(Color.Apple.backgroundComponent)
                    
                    ContainerRelativeShape()
                        .stroke(Color.Apple.componentInComponent, lineWidth: 6)
                }
            }
        } else {
            Text("widget_events_empty".localized)
                .multilineTextAlignment(.center)
                .padding()
        }
    } // End body
} // End struct
