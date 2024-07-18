//
//  Provider.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import Foundation
import WidgetKit

struct Provider: IntentTimelineProvider {
    
    // Repository
    let eventRepository = EventRepository.shared
    
    // Placeholder
    func placeholder(in context: Context) -> IntentEntry {
        let event: EventEntity? = eventRepository.fetchTheNextEventForDisplayInWidget()
        return IntentEntry(date: .now, configuration: ConfigurationIntent(), event: event)
    }

    // Snapshot
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (IntentEntry) -> ()) {
        let event: EventEntity? = eventRepository.fetchTheNextEventForDisplayInWidget()
        let entry = IntentEntry(date: .now, configuration: configuration, event: event)
        completion(entry)
    }
    
    // Timeline
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<IntentEntry>) -> ()) {
        var event: EventEntity? = nil
        
        if let showSoonestEvent = configuration.showSoonestEvent, showSoonestEvent.boolValue {
            event = eventRepository.fetchTheNextEventForDisplayInWidget()
        } else {
            if let eventForWidget = configuration.eventForWidget, let eventFoundByID = eventRepository.fetchEventWithCustomRequestForDisplayInWidget(
                eventID: eventForWidget.identifier!
            ) {
                event = eventFoundByID
            } else {
                event = eventRepository.fetchTheNextEventForDisplayInWidget()
                if let event {
                    configuration.eventForWidget = event.toEventForWidget()
                }
            }
        }
        
        var entries: [IntentEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = IntentEntry(date: entryDate, configuration: configuration, event: event)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
