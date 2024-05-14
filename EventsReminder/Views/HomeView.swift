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
    
    // Repository
    @State private var eventRepository = EventRepository.shared
    
    // Custom
    @State private var viewModel = HomeViewModel()
    @State private var filterViewModel = FilterViewModel.shared
    @State private var createNewEventViewModel = CreateNewEventViewModel()
    
    // MARK: -
    var body: some View {
        List {
            FilterToolbar()
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(Color.background.edgesIgnoringSafeArea(.all))
            ForEach(filterViewModel.eventStatus == .comingSoon ? eventRepository.eventsComingSoon : eventRepository.eventsDone) { event in
                Button(action: {
                    router.pushEventDetail(event: event)
                }, label: {
                    EventCell(event: event)
                })
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(Color.background.edgesIgnoringSafeArea(.all))
            }
        }
        .listStyle(.plain)
        .background(Color.background.ignoresSafeArea())
        .navigationTitle("Events".localized)
        .searchable(text: $viewModel.searchText, prompt: "Search a event".localized)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "crown.fill")
                })
                Button(action: { 
                    router.presentCreateNewEvent(viewModel: $createNewEventViewModel) {
                        createNewEventViewModel.resetData()
                    }
                }, label: {
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
