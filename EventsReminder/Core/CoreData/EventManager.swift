//
//  EventManager.swift
//  EventsReminder
//
//  Created by KaayZenn on 14/05/2024.
//

import Foundation
import WidgetKit

final class EventManager: ObservableObject {
    static let shared = EventManager()
    let viewContext = CoreDataStack.shared.viewContext
}

extension EventManager {
    
    func updatePastEventsToNextValidDate() async {
        let events = EventStore.shared.events
        
        for event in events {
            if event.date < .now {
                switch event.repeatType {
                case .none:
                    continue
                case .monthly:
                    event.date = event.date.advancedByOneMonth()
                    await NotificationManager.shared.createNotifications(event: event)
                case .yearly:
                    event.date = event.date.advancedByOneYear()
                    await NotificationManager.shared.createNotifications(event: event)
                }
            }
        }
        
        do {
            try CoreDataStack.shared.saveContext()
        } catch {
            // TODO: Manage errors
        }
        
        await EventStore.shared.fetchEvents()
    }
    
    func updatePastEventsToNextValidDateForWidget(events: [EventEntity]) {
        for event in events {
            if event.date < .now {
                switch event.repeatType {
                case .none:
                    continue
                case .monthly:
                    event.date = event.date.advancedByOneMonth()
                    Task {
                        await NotificationManager.shared.createNotifications(event: event)
                    }
                case .yearly:
                    event.date = event.date.advancedByOneYear()
                    Task {
                        await NotificationManager.shared.createNotifications(event: event)
                    }
                }
            }
        }
        
        do {
            try CoreDataStack.shared.saveContext()
        } catch {
            // TODO: Manage errors
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}
