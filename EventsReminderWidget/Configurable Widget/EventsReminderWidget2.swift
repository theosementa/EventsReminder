//
//  EventsReminderWidget2.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import WidgetKit
import SwiftUI

struct EventsReminderWidgetEntryView2: View {
    
    // Builder
    var entry: Provider.Entry
    
    //Environnement
    @Environment(\.widgetFamily) private var widgetFamily
    
    // MARK: -
    var body: some View {
        SmallWidget2(entry: entry)
    }
}

struct EventsReminderWidget2: Widget {
    let kind: String = "EventsReminderWidget2"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            EventsReminderWidgetEntryView2(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("widget_my_events".localized)
        .description("widget_on_home_screen".localized)
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}
