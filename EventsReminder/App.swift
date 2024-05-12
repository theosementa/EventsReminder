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
    
    let coreDataStack = CoreDataStack.shared
    let router = NavigationManager(isPresented: .constant(.home))

    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                HomeView(router: router)
            }
            .environment(\.managedObjectContext, coreDataStack.viewContext)
        }
    }
}
