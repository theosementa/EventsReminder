//
//  EventManager.swift
//  EventsReminder
//
//  Created by KaayZenn on 14/05/2024.
//

import Foundation

@Observable
final class EventManager {
    static let shared = EventManager()
    let viewContext = CoreDataStack.shared.viewContext
    
}

extension EventManager {
    
    func updatePastEventsToNextValidDate() {
        let events = EventRepository.shared.events
        
        for event in events {
            if event.date < .now {
                switch event.repeatType {
                case .none:
                    continue
                case .monthly:
                    event.date = event.date.advancedByOneMonth()
                    CoreDataStack.shared.saveContext()
                case .yearly:
                    event.date = event.date.advancedByOneYear()
                    CoreDataStack.shared.saveContext()
                }
            }
        }
        
        Task {
            await EventRepository.shared.fetchEvents()
        }
    }
    
}
