//
//  SettingsView.swift
//  EventsReminder
//
//  Created by KaayZenn on 27/05/2024.
//

import SwiftUI
import TheoKit

struct SettingsView: View {
    
    // Custom
    @State private var viewModel = SettingsViewModel()
    
    // MARK: -
    var body: some View {
        Form {
            Section {
                SettingCellPredefined(style: .general) {
                    
                }
                SettingCell(
                    icon: "bell.badge.fill",
                    backgroundColor: Color.red,
                    text: "word_notifications".localized,
                    isPush: true) {
                        
                    }
            }
            
            Section {
                SettingCellPredefined(style: .review) {
//                    if let langCode = Locale.current.language.languageCode {
//                        URLManager.openURL(url: "https://itunes.apple.com/app/https://apps.apple.com/\(langCode.identifier)/app/cashflow-tracker/id6450913423?action=write-review")
//                    }
                }
                
                SettingCellPredefined(style: .share) {
                    
                }
                
                SettingCellPredefined(style: .reportBug) {
                    viewModel.isMailForReportBug = true
                    viewModel.showMailView.toggle()
                }
                
                SettingCellPredefined(style: .suggestFeature) {
                    viewModel.isMailForReportBug = false
                    viewModel.showMailView.toggle()
                }
            }
            
            Section {
                SettingCellPredefined(style: .moreFromThisDev) {
                    URLManager.openURL(url: "https://apps.apple.com/fr/developer/theo-sementa/id1608409500")
                }
            }
            
            Section {
                SettingCellPredefined(style: .conditionOfUse) {
                    
                }
                
                SettingCellPredefined(style: .privacyPolicy) {
                    
                }
            }
            
            Section {
                SettingFooter(author: "Theo Sementa")
            }
        }
        .sheet(isPresented: $viewModel.showMailView) {
            MailView(
                result: $viewModel.result,
                recipients: ["theosementa.dev@gmail.com"],
                subject: viewModel.subjectForMailView()
            )
        }
        .navigationTitle("word_settings".localized)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsView()
    }
}
