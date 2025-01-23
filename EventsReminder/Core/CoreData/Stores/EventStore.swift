//
//  EventStore.swift
//  EventsReminder
//
//  Created by Theo Sementa on 23/01/2025.
//

import Foundation

final class EventStore: ObservableObject {
    static let shared = EventStore()
    
    @Published var events: [EventEntity] = []
}

extension EventStore {
    
    func fetchEvents() async {
        do {
            self.events = try await EventRepository.fetchEvents()
        } catch {
            // TODO: Error management
        }
    }
    
    func createEvent(creationModel: EventCreationModel) async {
        do {
            let newEvent = try await EventRepository.createEvent(creationModel: creationModel)
            self.events.append(newEvent)
            
            self.events = events
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        } catch {
            // TODO: Error management
        }
    }
    
    func updateEvent(updateModel: EventUpdateModel) {
        do {
            try EventRepository.updateEvent(updateModel: updateModel)
            
            if let index = events.firstIndex(where: { $0.id == updateModel.event.id }) {
                events[index] = updateModel.event
                
                self.events = events
                    .sorted(by: { $0.daysRemaining < $1.daysRemaining })
            }
        } catch {
            // TODO: Error management
        }
    }
    
    func deleteEvent(event: EventEntity) async {
        do {
            try EventRepository.deleteEvent(event)
            await fetchEvents()
        } catch {
            // TODO: Error management
        }
    }
    
}

extension EventStore {
    
    var eventsComingSoon: [EventEntity] {
        return events
            .filter { $0.daysRemaining >= 0 }
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
    }
    
    var eventsDone: [EventEntity] {
        return events
            .filter { $0.daysRemaining < 0 }
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
    }
    
    func eventsByTags(events: [EventEntity]) -> [TagEntity : [EventEntity]] {
        var dict: [TagEntity : [EventEntity]] = [:]
        
        for event in events {
            if let tag = event.tag {
                if dict[tag].isNotNil() {
                    dict[tag]!.append(event)
                } else {
                    dict[tag] = [event]
                }
            }
        }
        
        let dictSorted = dict.sorted { $0.key.name < $1.key.name }
        var newSortedDict: [TagEntity: [EventEntity]] = [:]
        
        for (tag, events) in dictSorted {
            newSortedDict[tag] = events.sorted(by: { $0.daysRemaining < $1.daysRemaining })
        }
                
        return newSortedDict
    }
    
}
