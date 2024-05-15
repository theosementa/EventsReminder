//
//  SmallWidget2.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI
import WidgetKit

struct SmallWidget2: View {
    
    // Builder
    var entry: SimpleEntry
    
    // MARK: -
    var body: some View {
        if let event = entry.event {
            VStack(spacing: 32) {
                VStack(spacing: -4) {
                    Text(event.daysRemaining.formatted())
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(event.tag?.color.toColor() ?? Color(uiColor: .label))
                    
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
                        .fill(Color.backgroundComponent)
                    
                    ContainerRelativeShape()
                        .stroke(Color.componentInComponent, lineWidth: 6)
                }
            }
        } else {
            Text("Fail to get an event")
        }
    } // End body
} // End struct
