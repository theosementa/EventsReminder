//
//  IntentEntry.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import Foundation
import WidgetKit

struct IntentEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let event: EventEntity?
}
