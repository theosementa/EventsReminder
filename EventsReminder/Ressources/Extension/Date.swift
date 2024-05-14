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
    
    func isMidnight() -> Bool {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        if let hour = components.hour, let minute = components.minute, let second = components.second {
            return hour == 0 && minute == 0 && second == 0
        } else {
            return false
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
}
