//
//  EventRepository.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

@Observable
@MainActor final class EventRepository {
    static let shared = EventRepository()
    let viewContext = CoreDataStack.shared.viewContext
    
    var events: [EventEntity] = []
}

@MainActor extension EventRepository {
    
    func fetchEvents() {
        let request = EventEntity.fetchRequest()
        do {
            self.events = []
            let events = try viewContext.fetch(request)
            self.events = events
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func createEvent(name: String, emoji: String, date: Date, repeatType: Repeat, tag: TagEntity?) {
        let newEvent = EventEntity(context: viewContext)
        newEvent.id = UUID()
        newEvent.name = name
        newEvent.emoji = emoji
        newEvent.date = date
        newEvent.repeatType = repeatType
        newEvent.tag = tag
        
        CoreDataStack.shared.saveContext()
        
        events.append(newEvent)
        self.events = events
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
    }
    
    func deleteEvent(_ event: EventEntity) {
        viewContext.delete(event)
        CoreDataStack.shared.saveContext()
        fetchEvents()
    }
    
}
