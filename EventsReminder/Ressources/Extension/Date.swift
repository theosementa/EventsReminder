//
//  Date.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

extension Date {
    
    func dateAtMidnight() -> Date {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        if let midnightDate = calendar.date(from: components) {
            return midnightDate
        } else {
            return self
        }
    }
    
    func advancedByOneMonth() -> Date {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: self) {
            return newDate
        } else {
            return self
        }
    }
    
    func advancedByOneYear() -> Date {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .year, value: 1, to: self) {
            return newDate
        } else {
            return self
        }
    }
    
    func toDateComponents(isForNotification: Bool = false) -> DateComponents {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        
        // If for notification, adjust to noon
        if isForNotification {
            components.hour = 12
            components.minute = 0
            components.second = 0
        }
        
        return components
    }
    
    func oneDayAgo(forNotification: Bool = false) -> Date? {
        if let date = Calendar.current.date(byAdding: .day, value: -1, to: self) {
            return forNotification ? date.atNoon() : date
        }
        return nil
    }
    
    func oneWeekAgo(forNotification: Bool = false) -> Date? {
        if let date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self) {
            return forNotification ? date.atNoon() : date
        }
        return nil
    }
    
    private func atNoon() -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = 12
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)
    }
}
