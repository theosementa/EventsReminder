//
//  Date.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

extension Date {
    
    func isMidnight() -> Bool {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        if let hour = components.hour, let minute = components.minute, let second = components.second {
            return hour == 0 && minute == 0 && second == 0
        } else {
            return false
        }
    }
    
}
