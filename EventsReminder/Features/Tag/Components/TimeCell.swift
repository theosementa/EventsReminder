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
                        
                    Text(timeDuration.months == 1 ? "word_month".localized : "word_months".localized)
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.days != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.days.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text(timeDuration.days == 1 ? "word_day".localized : "word_days".localized)
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.hours != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.hours.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text(timeDuration.hours == 1 ? "word_hour".localized : "word_hours".localized)
                        .font(.system(size: 14, weight: .medium))
                        .offset(y: -4)
                }
            }
            
            if timeDuration.minutes != 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeDuration.minutes.formatted())
                        .font(.system(size: 28, weight: .bold))
                        
                    Text(timeDuration.minutes == 1 ? "word_minute".localized : "word_minutes".localized)
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
