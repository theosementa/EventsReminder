//
//  EventFilter.swift
//  EventsReminder
//
//  Created by Theo Sementa on 23/01/2025.
//

import Foundation

enum EventFilter: CaseIterable {
    case eventToCome
    case alphabetic
    case tags
    
    var description: String {
        switch self {
        case .eventToCome:
            return "filter_upcoming_event".localized
        case .alphabetic:
            return "filter_alphabetic".localized
        case .tags:
            return "word_category".localized
        }
    }
}
