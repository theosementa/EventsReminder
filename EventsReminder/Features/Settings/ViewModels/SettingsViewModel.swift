//
//  SettingsViewModel.swift
//  EventsReminder
//
//  Created by KaayZenn on 27/05/2024.
//

import Foundation
import MessageUI
import TheoKit

final class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    @Published var result: Result<MFMailComposeResult, Error>? = nil
    @Published var showMailView: Bool = false
    @Published var isMailForReportBug: Bool = false
    
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
