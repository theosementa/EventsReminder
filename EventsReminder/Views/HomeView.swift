//
//  HomeView.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    // Builder
    var router: NavigationManager
    
    // MARK: -
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    HomeView(router: .init(isPresented: .constant(nil)))
        .environment(\.managedObjectContext, CoreDataStack.preview.viewContext)
}
