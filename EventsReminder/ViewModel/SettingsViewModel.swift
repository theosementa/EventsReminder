//
//  SettingsViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 27/05/2024.
//

import Foundation
import MessageUI
import TheoKit

@Observable
final class SettingsViewModel {
    static let shared = SettingsViewModel()
    
    var result: Result<MFMailComposeResult, Error>? = nil
    var showMailView: Bool = false
    var isMailForReportBug: Bool = false
    
}

extension SettingsViewModel {
    
    func subjectForMailView() -> String {
        if isMailForReportBug {
            return "[Events Reminder] " + "word_reportBug".localized + " :"
        } else {
            return "[Events Reminder] " + "word_suggestFeature".localized + " :"
        }
    }
    
}
