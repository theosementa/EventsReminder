//
//  EventsReminderApp.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI
import Observation

@main
struct EventsReminderApp: App {
    
    private let coreDataStack = CoreDataStack.shared
    private let router = NavigationManager(isPresented: .constant(.home))
    
    // Custom
    private let eventRepository = EventRepository.shared
    private let tagRepository = TagRepository.shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                HomeView(router: router)
            }
            .environment(\.managedObjectContext, coreDataStack.viewContext)
            .task {
                await eventRepository.fetchEvents()
                EventManager.shared.updatePastEventsToNextValidDate()
            }
            .onAppear {
                tagRepository.fetchTags()
            }
        }
    }
}
