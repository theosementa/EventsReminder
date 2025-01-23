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
    let viewContext = CoreDataStack.shared.viewContext
    
    @Published var events: [EventEntity] = []
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
    
    func createEvent(name: String, date: Date, repeatType: Repeat, tag: TagEntity?) {
        let newEvent = EventEntity(context: viewContext)
        newEvent.id = UUID()
        newEvent.name = name
        newEvent.date = date
        newEvent.repeatType = repeatType
        newEvent.tag = tag
        
        CoreDataStack.shared.saveContext()
        
        events.append(newEvent)
        Task {
            await NotificationManager.shared.createNotifications(event: newEvent)
        }
        
        self.events = events
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func updateEvent(event: EventEntity, name: String, date: Date, repeatType: Repeat, tag: TagEntity?) {
        event.name = name
        event.date = date
        event.repeatType = repeatType
        event.tag = tag
        
        CoreDataStack.shared.saveContext()
        
        self.events = events
            .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func deleteEvent(_ event: EventEntity) async {
        viewContext.delete(event)
        await fetchEvents()
        CoreDataStack.shared.saveContext()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}

// MARK: - WidgetHelper
extension EventRepository {
    
    func fetchEventsForWidget() -> [EventEntity] {
        let request = EventEntity.fetchRequest()
        do {
            self.events = []
            let events = try self.viewContext.fetch(request)
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: events)
            return events
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
        } catch { return [] }
    }
    
    func fetchEventWithCustomRequestForDisplayInWidget(eventID: String) -> EventEntity? {
        let request = EventEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", UUID(uuidString: eventID)! as CVarArg)
        
        do {
            let results = try self.viewContext.fetch(request)
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: results)
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
            EventManager.shared.updatePastEventsToNextValidDateForWidget(events: results)
            return results
                .sorted(by: { $0.daysRemaining < $1.daysRemaining })
                .first
        } catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
            return nil
        }
    }
    
} // End extension
