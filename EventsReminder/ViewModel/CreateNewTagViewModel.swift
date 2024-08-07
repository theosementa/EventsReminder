//
//  CreateNewTagViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import Foundation
import SwiftUI

@Observable
final class CreateNewTagViewModel {
    
    var color: Color = .blue
    var name: String = ""
    
}

extension CreateNewTagViewModel {
    
    func createNewTag() {
        if canTagBeCreated() {
            TagRepository.shared.createTag(
                name: name,
                color: UIColor(color)
            )
        } else {
            return
        }
    }

    func canTagBeCreated() -> Bool {
        if !name.isEmpty {
            return true
        } else {
            return false
        }
    }
    
}

