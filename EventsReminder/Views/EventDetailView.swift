//
//  EventDetailView.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import SwiftUI

struct EventDetailView: View {
    
    // Builder
    var router: NavigationManager
    @ObservedObject var event: EventEntity
    
    // Repository
    @State private var eventRepository: EventRepository = .shared
    
    // Custom
    @State private var createNewEventViewModel = CreateNewEventViewModel()
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        ZStack {
            event.tag?.color
                .toColor()
                .opacity(0.3)
                .ignoresSafeArea()
            
            RoundedRectangle(
                cornerRadius: UIScreen.main.displayCornerRadius,
                style: .continuous
            )
            .stroke(lineWidth: 6)
            .ignoresSafeArea()
            .foregroundStyle(event.tag?.color.toColor() ?? Color.componentInComponent)
            
            VStack(spacing: 40) {
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(event.tag?.color.toColor() ?? Color.componentInComponent)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text(event.emoji)
                                .font(.system(size: 28))
                        }
                    
                    VStack(spacing: 4) {
                        Text(event.name)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Text(event.fullDate)
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                
                VStack(spacing: 4) {
                    Text(event.daysRemaining.formatted())
                        .font(.system(size: 40, weight: .bold))
                    
                    Text("days remaining")
                        .font(.system(size: 16, weight: .medium))
                }
                
                TimeCell(timeDuration: TimeManager().calculateElapsedTime(from: event.date))
                                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } // End ZStack
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button(action: {
                        self.createNewEventViewModel = CreateNewEventViewModel(
                            emoji: event.emoji,
                            name: event.name,
                            tag: event.tag,
                            date: event.date,
                            repeatType: event.repeatType,
                            event: event
                        )
                        router.presentCreateNewEvent(viewModel: $createNewEventViewModel) {
                            createNewEventViewModel.resetData()
                        }
                    }, label: {
                        Label("Edit", systemImage: "pencil")
                    })
                    
                    Button(role: .destructive, action: {
                        dismiss()
                        eventRepository.deleteEvent(event)
                    }, label: {
                        Label("Delete", systemImage: "trash.fill")
                    })
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    } // End body
    
} // End struct

// MARK: - Preview
#Preview {
    EventDetailView(router: .init(isPresented: .constant(nil)), event: .preview1)
}
