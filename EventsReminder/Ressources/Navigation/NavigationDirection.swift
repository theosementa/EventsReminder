//
//  NavigationDirection.swift
//  Krabs
//
//  Created by Theo Sementa on 05/12/2023.
//

import Foundation
import SwiftUI

enum NavigationDirection: Identifiable {
    case home
    case createNewEvent
    case eventDetail(event: EventEntity)
    
    var id: String {
        switch self {
        case .home:
            return "home"
        case .createNewEvent:
            return "createNewEvent"
        case .eventDetail(let event):
            return "eventDetail_\(event.id)"
        }
    }
}

extension NavigationDirection: Equatable {
    static func == (lhs: NavigationDirection, rhs: NavigationDirection) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home),
            (.createNewEvent, .createNewEvent):
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
