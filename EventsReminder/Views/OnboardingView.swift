//
//  OnboardingView.swift
//  EventsReminder
//
//  Created by KaayZenn on 20/05/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        VStack {
            Text("Events Reminder")
                .font(.system(size: 32, weight: .heavy))
            
            ScrollView {
                onboardingCell(
                    icon: "clock.fill",
                    title: "word_events".localized,
                    desc: "onboarding_events".localized,
                    color: .red
                )
                
                onboardingCell(
                    icon: "slider.horizontal.3",
                    title: "word_advanced_filters".localized,
                    desc: "onboarding_filters".localized,
                    color: .orange
                )
                
                onboardingCell(
                    icon: "tag.fill",
                    title: "word_categories".localized,
                    desc: "onboarding_categories".localized,
                    color: .green
                )
                
                onboardingCell(
                    icon: "clock.arrow.2.circlepath",
                    title: "word_repeat".localized,
                    desc: "onboarding_repeat".localized,
                    color: .blue
                )
                
                onboardingCell(
                    icon: "square.grid.2x2",
                    title: "Widgets",
                    desc: "onboarding_widgets".localized,
                    color: .purple
                )
                
                onboardingCell(
                    icon: "bell.badge.fill",
                    title: "word_notifications".localized,
                    desc: "onboarding_notifications".localized,
                    color: .red
                )
                            
                onboardingCell(
                    icon: "icloud.fill",
                    title: "word_sync".localized,
                    desc: "onboarding_sync".localized,
                    color: .blue
                )
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            Button(action: { dismiss() }, label: {
                Text("word_start".localized)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.blue)
                    }
            })
            .padding()
        }
        .padding(.top, 32)
    } // End body
    
    // MARK: - ViewBuilder
    @ViewBuilder
    private func onboardingCell(icon: String, title: String, desc: String, color: Color) -> some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .frame(width: 40)
                .foregroundStyle(color)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                Text(desc)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 32)
    }
    
} // End struct

// MARK: - Preview
#Preview {
    OnboardingView()
}
