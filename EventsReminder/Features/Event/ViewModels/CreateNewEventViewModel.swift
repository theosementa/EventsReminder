//
//  CreateNewEventViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

final class CreateNewEventViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var tag: TagEntity? = nil
    @Published var date: Date = .now
    @Published var repeatType: Repeat = .none
    @Published var event: EventEntity? = nil
    
    init(event: EventEntity? = nil) {
        if let event {
            self.name = event.name
            self.tag = event.tag
            self.date = event.date
            self.repeatType = event.repeatType
            self.event = event
        }
    }
    
    @Published var allDay: Bool = true
    @Published var presentingConfirmationDialog: Bool = false
}

// MARK: - Creation
extension CreateNewEventViewModel {
    
    func createNewEvent() async {
        if canEventBeCreated() {
            await EventStore.shared.createEvent(
                creationModel: .init(
                    name: name,
                    date: allDay ? date.dateAtMidnight() : date,
                    repeatType: repeatType,
                    tag: tag
                )
            )
        } else { return }
    }
    
    func updateEvent(_ event: EventEntity) async {
        if canEventBeCreated() {
            await EventStore.shared.updateEvent(
                updateModel: .init(
                    event: event,
                    name: name,
                    date: allDay ? date.dateAtMidnight() : date,
                    repeatType: repeatType,
                    tag: tag
                )
            )
        } else { return }
    }
    
    func resetData() {
        self.name = ""
        self.tag = nil
        self.date = .now
        self.repeatType = .none
        
        self.allDay = true
        
        self.presentingConfirmationDialog = false
    }
    
}

// MARK: - Verification
extension CreateNewEventViewModel {
    
    func canEventBeCreated() -> Bool {
        if !name.isEmptyWithoutSpace() {
            return true
        } else {
            return false
        }
    }
    
    func isEventInCreation() -> Bool {
        if !name.isEmptyWithoutSpace() || !tag.isNil() || repeatType != .none {
            return true
        } else { return false }
    }
    
}
