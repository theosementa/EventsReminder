//
//  CreateNewEventViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

@Observable
final class CreateNewEventViewModel {
    
    var emoji: String = ""
    var name: String = ""
    var tag: TagEntity? = nil
    var date: Date = Date()
    var repeatType: Repeat = .none
    
    var allDay: Bool = true
    
    var notifOneDayBefore: Bool = false
    var notifThreeDayBefore: Bool = false
    var notifOneWeekBefore: Bool = false
    var notifOneMonthBefore: Bool = false
    
    var heightOfTextField: CGFloat = 0
    var presentingConfirmationDialog: Bool = false
    
}

// MARK: - UI
extension CreateNewEventViewModel {
    
    var nbrNotifs: Int {
        var num: Int = 0
        if notifOneDayBefore { num += 1 }
        if notifThreeDayBefore { num += 1 }
        if notifOneWeekBefore { num += 1 }
        if notifOneMonthBefore { num += 1 }
        
        return num
    }
    
}

// MARK: - Creation
extension CreateNewEventViewModel {
    
    func createNewEvent() {
        if canEventBeCreated() {
            EventRepository.shared.createEvent(
                name: name,
                emoji: emoji,
                date: date,
                repeatType: repeatType,
                tag: tag
            )
        } else {
            return
        }
    }
    
}

// MARK: - Verification
extension CreateNewEventViewModel {
    
    func canEventBeCreated() -> Bool {
        if !emoji.isEmpty || !name.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func isEventInCreation() -> Bool {
        if !emoji.isEmpty || !name.isEmpty || !tag.isNil() || repeatType != .none {
            return true
        } else { return false }
    }
    
}
