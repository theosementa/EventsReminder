//
//  ListOfEventsByTagsView.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI

struct ListOfEventsByTagsView: View {
    
    // Builder
    var router: NavigationManager
    
    // Repository
    @EnvironmentObject private var eventStore: EventStore
    
    // Custom
    @State private var filterViewModel: FilterManager = .shared
    
    // MARK: -
    var body: some View {
        let events: [EventEntity] = filterViewModel.eventStatus == .comingSoon ? eventStore.eventsComingSoon : eventStore.eventsDone
        ForEach(eventStore.eventsByTags(events: events).keys.sorted { $0.name < $1.name }, id: \.self) { tag in
            VStack(spacing: 8) {
                HStack {
                    Text(tag.name.uppercased())
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(tag.color.toColor())
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.top, 4)
                VStack(spacing: 4) {
                    ForEach(eventStore.eventsByTags(events: events)[tag] ?? []) { event in
                        EventRow(event: event)
                            .onTapGesture {
                                router.pushEventDetail(event: event)
                            }
                    }
                }
            }
            .padding(8)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(tag.color.toColor().opacity(0.3))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(tag.color.toColor(), lineWidth: 2)
                }
            }
            .padding(.bottom, 8)
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    ListOfEventsByTagsView(router: .init(isPresented: .constant(nil)))
}
