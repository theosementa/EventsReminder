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
            return "word_comingsoon".localized
        case .done:
            return "word_done".localized
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
            return "filter_upcoming_event".localized
        case .alphabetic:
            return "filter_alphabetic".localized
        case .tags:
            return "word_category".localized
        }
    }
}

final class FilterViewModel: ObservableObject {
    static let shared = FilterViewModel()
    
    @Published var eventStatus: EventStatus = .comingSoon

    @Published var filterSelected: EventFilter = .eventToCome
    @Published var eventToCome: Bool = true
    @Published var alphabeticOrder: Bool = true
    
}
