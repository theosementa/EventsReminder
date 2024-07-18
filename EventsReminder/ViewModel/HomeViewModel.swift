//
//  HomeViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

@Observable
final class HomeViewModel {
    let eventRepository: EventRepository = .shared
    var filterViewModel: FilterViewModel = .shared
    
    var searchText: String = ""
    
}

extension HomeViewModel {
    
    var searchResults: [EventEntity] {
        let events = (filterViewModel.eventStatus == .comingSoon ? eventRepository.eventsComingSoon : eventRepository.eventsDone)
            .sorted {
                switch filterViewModel.filterSelected {
                case .eventToCome:
                    if filterViewModel.eventToCome {
                        return $0.daysRemaining < $1.daysRemaining
                    } else {
                        return $0.daysRemaining > $1.daysRemaining
                    }
                case .alphabetic:
                    if filterViewModel.alphabeticOrder {
                        return $0.name < $1.name
                    } else {
                        return $0.name > $1.name
                    }
                default:
                    return $0.daysRemaining < $1.daysRemaining
                }
            }
        
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    

}
