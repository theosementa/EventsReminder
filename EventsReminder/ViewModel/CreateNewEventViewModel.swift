//
//  CreateNewEventViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

@Observable
final class CreateNewEventViewModel {
    
    var emoji: String
    var name: String
    var tag: TagEntity?
    var date: Date
    var repeatType: Repeat
    var event: EventEntity?
    
    init(emoji: String = "🎂", name: String = "", tag: TagEntity? = nil, date: Date = .now, repeatType: Repeat = .none, event: EventEntity? = nil) {
        self.emoji = emoji
        self.name = name
        self.tag = tag
        self.date = date
        self.repeatType = repeatType
        self.event = event
    }
    
    var allDay: Bool = true
    
    var presentingConfirmationDialog: Bool = false

}

// MARK: - Creation
extension CreateNewEventViewModel {
    
    func createNewEvent() {
        if canEventBeCreated() {
            EventRepository.shared.createEvent(
                name: name,
                emoji: emoji,
                date: allDay ? date.dateAtMidnight() : date,
                repeatType: repeatType,
                tag: tag
            )
        } else { return }
    }
    
    func updateEvent(_ event: EventEntity) {
        if canEventBeCreated() {
            EventRepository.shared.updateEvent(
                event: event,
                name: name,
                emoji: emoji,
                date: allDay ? date.dateAtMidnight() : date,
                repeatType: repeatType,
                tag: tag
            )
        } else { return }
    }
    
    func resetData() {
        self.emoji = "🎂"
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
        if !emoji.isEmpty && !name.isEmptyWithoutSpace() {
            return true
        } else {
            return false
        }
    }
    
    func isEventInCreation() -> Bool {
        if !emoji.isEmpty || !name.isEmptyWithoutSpace() || !tag.isNil() || repeatType != .none {
            return true
        } else { return false }
    }
    
}
