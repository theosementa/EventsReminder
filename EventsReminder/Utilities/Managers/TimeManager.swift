//
//  TimeManager.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import Foundation

struct TimeDuration {
    var months: Int
    var days: Int
    var hours: Int
    var minutes: Int
}

final class TimeManager {
    
    func calculateElapsedTime(from endDate: Date) -> TimeDuration {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now, to: endDate)
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        let totalMonths = years * 12 + months
        let timeDuration = TimeDuration(months: totalMonths, days: days, hours: hours, minutes: minutes)
        
        return timeDuration
    }
    
}
