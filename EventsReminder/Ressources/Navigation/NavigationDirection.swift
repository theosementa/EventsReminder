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
    
    var id: String {
        switch self {
        case .home:
            return "home"
        }
    }
}

extension NavigationDirection: Equatable {
    static func == (lhs: NavigationDirection, rhs: NavigationDirection) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
            
//        case let (.createVehicleSheet(lhsVehicleSheet), .createVehicleSheet(rhsVehicleSheet)):
//            return lhsVehicleSheet == rhsVehicleSheet
            
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
