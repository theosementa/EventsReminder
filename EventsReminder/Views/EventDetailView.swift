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
            .foregroundStyle(event.tag?.color.toColor() ?? Color.Apple.componentInComponent)
            
            VStack(spacing: 40) {
                VStack(spacing: 24) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(event.tag?.color.toColor() ?? Color.Apple.componentInComponent)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text(event.emoji)
                                .font(.system(size: 28))
                        }
                    
                    Text(event.name)
                        .font(.system(size: 22, weight: .semibold))
                    
                    VStack(spacing: 4) {
                        Text(event.fullDate)
                            .font(.system(size: 16, weight: .medium))
                        
                        if event.repeatType != .none {
                            Text("word_repeat".localized + " : " + event.repeatType.description)
                                .font(.system(size: 14, weight: .medium))
                        }
                    }
                }
                
                VStack(spacing: 4) {
                    Text(event.daysRemaining.formatted())
                        .font(.system(size: 40, weight: .bold))
                    
                    Text("word_days_remaining".localized)
                        .font(.system(size: 16, weight: .medium))
                }
                
                if !event.isFault {
                    TimeCell(timeDuration: TimeManager().calculateElapsedTime(from: event.date))
                }
                                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
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
                        Label("word_edit".localized, systemImage: "pencil")
                    })
                    
                    Button(role: .destructive, action: {
                        Task {
                            await eventRepository.deleteEvent(event)
                            dismiss()
                        }
                    }, label: {
                        Label("word_delete".localized, systemImage: "trash.fill")
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
