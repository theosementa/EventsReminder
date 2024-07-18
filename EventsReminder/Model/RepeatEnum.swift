//
//  RepeatEnum.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation

public enum Repeat: Int, CaseIterable {
    case none
    case monthly
    case yearly
    
    var description: String {
        switch self {
        case .none:
            return "word_none".localized
        case .monthly:
            return "word_monthly".localized
        case .yearly:
            return "word_yearly".localized
        }
    }
}
