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
    @Environment(EventRepository.self) private var eventRepository
    @Environment(TagRepository.self) private var tagRepository
    
    // Custom
    @State private var viewModel = HomeViewModel()
    @State private var createNewEventViewModel = CreateNewEventViewModel()
    
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
                    if viewModel.filterViewModel.filterSelected == .tags {
                        ListOfEventsByTagsView(router: router)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 16, bottom: 6, trailing: 16))
                            .listRowBackground(Color.Apple.background.edgesIgnoringSafeArea(.all))
                    } else {
                        ForEach(viewModel.searchResults) { event in
                            Button(action: {
                                router.pushEventDetail(event: event)
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
                    router.presentCreateNewEvent(viewModel: $createNewEventViewModel) {
                        createNewEventViewModel.resetData()
                    }
                }
            .padding()
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
