//
//  EventRepository.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

@Observable
final class EventRepository {
    static let shared = EventRepository()
    let viewContext = CoreDataStack.shared.viewContext
    
    var events: [EventEntity] = []
}

extension EventRepository {
    
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
    
}

extension EventRepository {
    
    @MainActor
    func fetchEvents() async {
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
    
    func updateEvent(event: EventEntity, name: String, emoji: String, date: Date, repeatType: Repeat, tag: TagEntity?) {
        event.name = name
        event.emoji = emoji
        event.date = date
        event.repeatType = repeatType
        event.tag = tag
        
        CoreDataStack.shared.saveContext()
        
        self.events = events
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
    }
    
    func deleteEvent(_ event: EventEntity) {
        viewContext.delete(event)
        Task {
            await fetchEvents()
            CoreDataStack.shared.saveContext()
        }
    }
    
}

// MARK: - WidgetHelper
extension EventRepository {
    
    func fetchEventsForWidget() -> [EventEntity] {
        let request = EventEntity.fetchRequest()
        do {
            self.events = []
            let events = try self.viewContext.fetch(request)
            return events
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        } catch { return [] }
    }
    
    func fetchEventWithCustomRequestForDisplayInWidget(eventID: String) -> EventEntity? {
        let request = EventEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", UUID(uuidString: eventID)! as CVarArg)
        
        do {
            let results = try self.viewContext.fetch(request)
            return results.first
        } catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
            return nil
        }
    }
    
    func fetchTheNextEventForDisplayInWidget() -> EventEntity? {
        let request = EventEntity.fetchRequest()
        
        do {
            let results = try self.viewContext.fetch(request)
            return results
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
                .first
        } catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
            return nil
        }
    }
    
} // End extension
