//
//  NavigationDirection.swift
//  Krabs
//
//  Created by Theo Sementa on 05/12/2023.
//

import Foundation
import SwiftUI

enum NavigationDirection: Identifiable {
    case onboarding
    case home
    case settings
    case createNewEvent(event: EventEntity? = nil)
    case eventDetail(event: EventEntity)
    
    var id: Self { return self }
}

extension NavigationDirection: Equatable {
    static func == (lhs: NavigationDirection, rhs: NavigationDirection) -> Bool {
        switch (lhs, rhs) {
        case (.onboarding, .onboarding),
            (.home, .home),
            (.createNewEvent, .createNewEvent),
            (.settings, .settings):
            return true
            
        case let (.eventDetail(lhsEvent), .eventDetail(rhsEvent)):
            return lhsEvent.id == rhsEvent.id
            
        default:
            return false
        }
    }
}

extension NavigationDirection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
