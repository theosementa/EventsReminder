//
//  HomeViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    let eventStore: EventStore = .shared
    let filterManager: FilterManager = .shared
    
    @Published var searchText: String = ""
    @Published var selectedEvent: EventEntity?
    @Published var showEventDetails: Bool = false
}

extension HomeViewModel {
    
    var searchResults: [EventEntity] {
        let events = (filterManager.eventStatus == .comingSoon ? eventStore.eventsComingSoon : eventStore.eventsDone)
            .sorted {
                switch filterManager.filterSelected {
                case .eventToCome:
                    if filterManager.eventToCome {
                        return $0.daysRemaining < $1.daysRemaining
                    } else {
                        return $0.daysRemaining > $1.daysRemaining
                    }
                case .alphabetic:
                    if filterManager.alphabeticOrder {
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
