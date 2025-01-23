//
//  EventRepository.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation
import WidgetKit
import TheoKit

final class EventRepository: ObservableObject {
    static let shared = EventRepository()
}

extension EventRepository {
    
    @MainActor
    static func fetchEvents() async throws -> [EventEntity] {
        let viewContext = CoreDataStack.shared.viewContext
        let request = EventEntity.fetchRequest()
        
        let events = try viewContext.fetch(request)
        return events
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
    }
    
    static func createEvent(creationModel: EventCreationModel) async throws -> EventEntity {
        let viewContext = CoreDataStack.shared.viewContext
        
        let newEvent = EventEntity(context: viewContext)
        newEvent.id = UUID()
        newEvent.name = creationModel.name
        newEvent.date = creationModel.date
        newEvent.repeatType = creationModel.repeatType
        newEvent.tag = creationModel.tag
        
        try CoreDataStack.shared.saveContext()
        
        await NotificationManager.shared.createNotifications(event: newEvent)
        WidgetCenter.shared.reloadAllTimelines()
        
        return newEvent
    }
    
    static func updateEvent(updateModel: EventUpdateModel) throws {
        let event = updateModel.event
        
        event.name = updateModel.name
        event.date = updateModel.date
        event.repeatType = updateModel.repeatType
        event.tag = updateModel.tag
        
        try CoreDataStack.shared.saveContext()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    static func deleteEvent(_ event: EventEntity) throws {
        let viewContext = CoreDataStack.shared.viewContext
        
        viewContext.delete(event)
        
        try CoreDataStack.shared.saveContext()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}

// MARK: - WidgetHelper
extension EventRepository {
    
    func fetchEventsForWidget() -> [EventEntity] {
        let viewContext = CoreDataStack.shared.viewContext
        let request = EventEntity.fetchRequest()
        
        do {
            let events = try viewContext.fetch(request)
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: events)
            return events
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        } catch let error as NSError {
            print("Could not fetch.\(error.userInfo)")
            return []
        }
    }
    
    func fetchEventWithCustomRequestForDisplayInWidget(eventID: String) -> EventEntity? {
        let viewContext = CoreDataStack.shared.viewContext
        let request = EventEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", UUID(uuidString: eventID)! as CVarArg)
        
        do {
            let results = try viewContext.fetch(request)
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: results)
            
            return results.first
        } catch let error as NSError {
            print("Could not fetch.\(error.userInfo)")
            return nil
        }
    }
    
    func fetchTheNextEventForDisplayInWidget() -> EventEntity? {
        let viewContext = CoreDataStack.shared.viewContext
        let request = EventEntity.fetchRequest()
        
        do {
            let results = try viewContext.fetch(request)
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: results)
            
            return results
                .filter { $0.daysRemaining >= 0 }
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
                .first
        } catch let error as NSError {
            print("Could not fetch.\(error.userInfo)")
            return nil
        }
    }
    
}
