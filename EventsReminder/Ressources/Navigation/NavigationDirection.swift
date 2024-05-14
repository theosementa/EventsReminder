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
    case createNewEvent(viewModel: Binding<CreateNewEventViewModel>)
    case eventDetail(event: EventEntity)
    
    var id: String {
        switch self {
        case .home:
            return "home"
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
        case (.home, .home):
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
