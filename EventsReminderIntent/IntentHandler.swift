//
//  IntentHandler.swift
//  EventsReminderIntent
//
//  Created by KaayZenn on 15/05/2024.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    // Repository
    let eventRepository = EventRepository.shared
    
//    func defaultParameter(for intent: ConfigurationIntent)
    
    func provideEventForWidgetOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<EventForWidget>?, (any Error)?) -> Void) {
        let events: [EventEntity] = eventRepository.fetchEventsForWidget()
        
        let eventsToEventForWidget = events
            .map { EventForWidget(identifier: $0.id.uuidString, display: $0.name) }
        
        let eventsObjectCollection = INObjectCollection(items: eventsToEventForWidget)
        completion(eventsObjectCollection, nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        return self
    }
}
