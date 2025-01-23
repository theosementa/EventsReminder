//
//  HomeView.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI
import TheoKit

struct HomeView: View {
    
    // Builder
    var router: NavigationManager
    
    // Repository
    @EnvironmentObject private var eventRepository: EventRepository
    @EnvironmentObject private var tagRepository: TagRepository
    @EnvironmentObject private var filterManager: FilterManager
    
    // Custom
    @StateObject private var viewModel = HomeViewModel()
    
    // Preference
    @Preference(\.isFirstLaunch) private var isFirstLaunch
    
    // MARK: -
    var body: some View {
        VStack {
            if eventRepository.events.isEmpty {
                Text("home_add_first_event".localized)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List {
                    FilterToolbar()
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 16, bottom: 6, trailing: 16))
                        .listRowBackground(Color.Apple.background.edgesIgnoringSafeArea(.all))
                    
                    if filterManager.filterSelected == .tags {
                        ListOfEventsByTagsView(router: router)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 16, bottom: 6, trailing: 16))
                            .listRowBackground(Color.Apple.background.edgesIgnoringSafeArea(.all))
                    } else {
                        ForEach(viewModel.searchResults) { event in
                            Button(action: {
                                withAnimation(.smooth) {
                                    viewModel.selectedEvent = event
                                    viewModel.showEventDetails.toggle()
                                }
                            }, label: {
                                EventRow(event: event)
                            })
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                            .listRowBackground(Color.Apple.background.edgesIgnoringSafeArea(.all))
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .contentMargins(.bottom, 100, for: .scrollContent)
                .animation(.smooth, value: viewModel.searchResults)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Apple.background.ignoresSafeArea())
        .overlay(alignment: .bottomTrailing) {
            AddButton(
                foregroundColor: Color.white,
                backgroundColor: Color.blue) {
                    router.presentCreateNewEvent()
                }
            .padding()
        }
        .semiCustomSheet(isPresented: $viewModel.showEventDetails, withDismissButton: false) {
            if let event = viewModel.selectedEvent {
                EventDetailView(router: router, event: event)
            }
        }
        .navigationTitle("word_events".localized)
        .searchable(text: $viewModel.searchText, prompt: "home_search_event".localized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: router.pushSettings, label: {
                    Image(systemName: "gearshape.fill")
                })
            }
        }
        .refreshable {
            await eventRepository.fetchEvents()
            tagRepository.fetchTags()
        }
        .onAppear {
            if isFirstLaunch {
                router.presentOnboarding {
                    Task {
                        await eventRepository.fetchEvents()
                        isFirstLaunch = false
                    }
                }
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    HomeView(router: .init(isPresented: .constant(nil)))
        .environment(\.managedObjectContext, CoreDataStack.shared.viewContext)
}
