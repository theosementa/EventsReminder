//
//  EventsReminderWidget.swift
//  EventsReminderWidget
//
//  Created by KaayZenn on 15/05/2024.
//

import WidgetKit
import SwiftUI

struct EventsReminderWidgetEntryView : View {
    
    // Builder
    var entry: Provider.Entry
    
    //Environnement
    @Environment(\.widgetFamily) private var widgetFamily
    
    // MARK: -
    var body: some View {
        SmallWidget1(entry: entry)
//        if let event = entry.event {
//            SmallWidget1(entry: entry)
//        } else {
//            Text("Edit Widget to choose a event.")
//        }
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
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

// MARK: - Preview
#Preview(as: .systemSmall) {
    EventsReminderWidget()
} timeline: {
    IntentEntry(date: .now, configuration: ConfigurationIntent(), event: EventEntity.preview1)
}
