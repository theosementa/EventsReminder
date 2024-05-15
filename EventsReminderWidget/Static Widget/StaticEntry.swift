//
//  StaticEntry.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import Foundation
import WidgetKit

struct StaticEntry: TimelineEntry {
    let date: Date
    let events: [EventEntity]
}
