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
    
    // Custom
    @State private var eventRepository = EventRepository.shared
    @State private var viewModel = HomeViewModel()
    
    // MARK: -
    var body: some View {
        List(eventRepository.events) { event in
            EventCell(event: event)
        }
        .navigationTitle("Events".localized)
        .searchable(text: $viewModel.searchText, prompt: "Search a event".localized)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "crown.fill")
                })
                Button(action: {}, label: {
                    Image(systemName: "plus")
                })
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    HomeView(router: .init(isPresented: .constant(nil)))
        .environment(\.managedObjectContext, CoreDataStack.preview.viewContext)
}
