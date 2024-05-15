//
//  Provider.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import Foundation
import WidgetKit

struct Provider: IntentTimelineProvider {
    
    // Placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        let eventRepository: EventRepository = .shared

        Task {
            await eventRepository.fetchEvents()
        }
        
        let event: EventEntity? = eventRepository.events.first
        
        return SimpleEntry(date: .now, configuration: ConfigurationIntent(), event: event)
    }

    // Snapshot
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let eventRepository: EventRepository = .shared

        Task {
            await eventRepository.fetchEvents()
        }
        let event: EventEntity? = eventRepository.events.first
        
        let entry = SimpleEntry(date: .now, configuration: configuration, event: event)
        completion(entry)
    }
    
    // Timeline
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let eventRepository: EventRepository = .shared
        
        let event: EventEntity? = eventRepository.fetchEventWithCustomRequestForDisplayInWidget(
            eventID: configuration.parameter!.identifier!
        )
        
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, event: event)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
