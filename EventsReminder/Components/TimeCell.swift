//
//  TimeCell.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import SwiftUI

struct TimeCell: View {
    
    // Builder
    var timeDuration: TimeDuration
    
    // MARK: -
    var body: some View {
        HStack(spacing: 12) {
            if timeDuration.months != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.months.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text("months")
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.days != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.days.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text("days")
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.hours != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.hours.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text("hours")
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.minutes != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.minutes.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text("minutes")
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    TimeCell(timeDuration: .init(months: 1, days: 12, hours: 10, minutes: 45))
}
