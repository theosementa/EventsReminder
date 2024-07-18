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
    case createNewEvent(viewModel: Binding<CreateNewEventViewModel>)
    case eventDetail(event: EventEntity)
    
    var id: String {
        switch self {
        case .onboarding:
            return "onboarding"
        case .home:
            return "home"
        case .settings:
            return "settings"
        case .createNewEvent(let viewModel):
            return "createNewEvent_\(viewModel)"
        case .eventDetail(let event):
            return "eventDetail_\(event.id)"
        }
    }
}

extension NavigationDirection: Equatable {
    static func == (lhs: NavigationDirection, rhs: NavigationDirection) -> Bool {
        switch (lhs, rhs) {
        case (.onboarding, .onboarding),
            (.home, .home),
            (.settings, .settings):
            return true
            
        case let (.createNewEvent(lhsViewModel), .createNewEvent(rhsViewModel)):
            return lhsViewModel.name.wrappedValue == rhsViewModel.name.wrappedValue
            
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
