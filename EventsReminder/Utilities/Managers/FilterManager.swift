//
//  FilterManager.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import Foundation

final class FilterManager: ObservableObject {
    static let shared = FilterManager()
    
    @Published var eventStatus: EventStatus = .comingSoon

    @Published var filterSelected: EventFilter = .eventToCome
    @Published var eventToCome: Bool = true
    @Published var alphabeticOrder: Bool = true
}
