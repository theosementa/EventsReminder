//
//  Optionnal.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

extension Optional {
    
    func isNil() -> Bool {
        return self == nil
    }
    
    func isNotNil() -> Bool {
        return self != nil
    }
    
}
