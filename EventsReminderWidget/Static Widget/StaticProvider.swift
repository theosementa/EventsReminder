//
//  StaticProvider.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import Foundation
import WidgetKit

class StaticProvider: TimelineProvider {
    
    // Repository
    let eventRepository = EventRepository.shared
    
    func placeholder(in context: Context) -> StaticEntry {
        let events: [EventEntity] = eventRepository.fetchEventsForWidget()
        return StaticEntry(date: .now, events: events)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (StaticEntry) -> Void) {
        let events: [EventEntity] = eventRepository.fetchEventsForWidget()
        let entry = StaticEntry(date: .now, events: events)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<StaticEntry>) -> Void) {
        let events: [EventEntity] = eventRepository.fetchEventsForWidget()
        var entries: [StaticEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = StaticEntry(date: entryDate, events: events)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}
