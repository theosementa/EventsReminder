//
//  FilterViewModel.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import Foundation

enum EventStatus: CaseIterable {
    case comingSoon
    case done
    
    var description: String {
        switch self {
        case .comingSoon:
            return "Coming soon"
        case .done:
            return "Done"
        }
    }
}

enum EventFilter: CaseIterable {
    case eventToCome
    case alphabetic
    case tags
    
    var description: String {
        switch self {
        case .eventToCome:
            return "Event to come"
        case .alphabetic:
            return "Alphabetic"
        case .tags:
            return "Category"
        }
    }
}

@Observable
final class FilterViewModel {
    static let shared = FilterViewModel()
    
    var eventStatus: EventStatus = .comingSoon
    
    var filterSelected: EventFilter = .eventToCome
    var eventToCome: Bool = true
    var alphabeticOrder: Bool = true
    
}
