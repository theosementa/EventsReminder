//
//  EventsReminderWidget3.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import WidgetKit
import SwiftUI

struct EventsReminderWidgetEntryView3: View {
    
    // Builder
    var entry: StaticProvider.Entry
    
    //Environnement
    @Environment(\.widgetFamily) private var widgetFamily
    
    // MARK: -
    var body: some View {
        if widgetFamily == .systemMedium {
            MediumWidget1(events: Array(entry.events.prefix(2)))
        } else if widgetFamily == .systemLarge {
            MediumWidget1(events: Array(entry.events.prefix(5)))
        } else {
            Text("Fail to get widget")
        }
    }
}

struct EventsReminderWidget3: Widget {
    let kind: String = "EventsReminderWidget3"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: StaticProvider()) { entry in
                EventsReminderWidgetEntryView3(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
            .configurationDisplayName("My events")
            .description("View your events on your home screen.")
            .supportedFamilies([.systemMedium, .systemLarge])
            .contentMarginsDisabled()
    }
}
