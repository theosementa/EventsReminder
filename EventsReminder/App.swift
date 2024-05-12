//
//  EventsReminderApp.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI

@main
struct EventsReminderApp: App {
    let coreDataStack = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.viewContext)
        }
    }
}
