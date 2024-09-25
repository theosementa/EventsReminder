//
//  CreateNewTagViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import Foundation
import SwiftUI

final class CreateNewTagViewModel: ObservableObject {
    
    @Published var color: Color = .blue
    @Published var emoji: String = "🎂"
    @Published var name: String = ""
    
    @Published var showEmojiPicker: Bool = false
    
}

extension CreateNewTagViewModel {
    
    func createNewTag() {
        if canTagBeCreated() {
            TagRepository.shared.createTag(
                emoji: emoji,
                name: name,
                color: UIColor(color)
            )
        } else {
            return
        }
    }

    func canTagBeCreated() -> Bool {
        if !name.isEmpty && !emoji.isEmpty {
            return true
        } else {
            return false
        }
    }
    
}

