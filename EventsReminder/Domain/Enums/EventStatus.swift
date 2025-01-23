//
//  EventStatus.swift
//  EventsReminder
//
//  Created by Theo Sementa on 23/01/2025.
//

import Foundation

enum EventStatus: CaseIterable {
    case comingSoon
    case done
    
    var description: String {
        switch self {
        case .comingSoon:
            return "word_comingsoon".localized
        case .done:
            return "word_done".localized
        }
    }
}
