//
//  EventsReminderWidget.swift
//  EventsReminderWidget
//
//  Created by KaayZenn on 15/05/2024.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    
    // Placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        let eventRepository: EventRepository = .shared

        Task {
            await eventRepository.fetchEvents()
        }
        
        let events = eventRepository.events
        let event: EventEntity? = events.first
        
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

        Task {
            await eventRepository.fetchEvents()
        }
        let event: EventEntity? = eventRepository.events.first
        
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let event: EventEntity?
}

struct EventsReminderWidgetEntryView : View {
    
    // Builder
    var entry: Provider.Entry
    
    //Environnement
    @Environment(\.widgetFamily) private var widgetFamily
    
    // MARK: -
    var body: some View {
        if let event = entry.event {
            Text(event.name)
        } else {
            Text("Edit Widget to choose a event.")
        }
    }
}

struct EventsReminderWidget: Widget {
    let kind: String = "EventsReminderWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            EventsReminderWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My events")
        .description("View your events on your home screen.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Preview
#Preview(as: .systemSmall) {
    EventsReminderWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: ConfigurationIntent(), event: EventEntity.preview1)
}
