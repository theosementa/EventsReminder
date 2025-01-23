//
//  EventsReminderApp.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI
import WidgetKit

@main
struct EventsReminderApp: App {
    
    // Custom
    private let coreDataStack = CoreDataStack.shared
    private let router = NavigationManager(isPresented: .constant(.home))
    
    // Stores
    @StateObject private var eventStore: EventStore = .shared
    private let tagRepository = TagRepository.shared
    
    @StateObject private var filterManager: FilterManager = .shared
    
    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                HomeView(router: router)
            }
            .environment(\.managedObjectContext, coreDataStack.viewContext)
            .environmentObject(eventStore)
            .environmentObject(tagRepository)
            .environmentObject(filterManager)
            .task {
                await eventStore.fetchEvents()
                await EventManager.shared.updatePastEventsToNextValidDate()
            }
            .onAppear {
                tagRepository.fetchTags()
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}
