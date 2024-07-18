//
//  FilterToolbar.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import SwiftUI

struct FilterToolbar: View {
    
    // Custom
    @State private var viewModel = FilterViewModel.shared
    
    // MARK: -
    var body: some View {
        HStack {
            Menu {
                ForEach(EventStatus.allCases, id: \.self) { status in
                    Button { viewModel.eventStatus = status } label: {
                        Text(status.description)
                    }
                }
            } label: {
                Text(viewModel.eventStatus.description)
                    .font(.system(size: 12, weight: .semibold))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 10, weight: .semibold))
            }
            .tint(Color(uiColor: .gray))
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.Apple.backgroundComponent)
            }
            
            Spacer()
            
            Menu {
                Menu {
                    Button(action: {
                        viewModel.filterSelected = .alphabetic
                        viewModel.alphabeticOrder = true
                    }, label: {
                        Text("A -> Z")
                    })
                    Button(action: {
                        viewModel.filterSelected = .alphabetic
                        viewModel.alphabeticOrder = false
                    }, label: {
                        Text("Z -> A")
                    })
                } label: {
                    Text("filter_alphabetic".localized)
                }
                
                Menu {
                    Button(action: {
                        viewModel.filterSelected = .eventToCome
                        viewModel.eventToCome = true
                    }, label: {
                        Text("filter_nearest".localized)
                    })
                    Button(action: {
                        viewModel.filterSelected = .eventToCome
                        viewModel.eventToCome = false
                    }, label: {
                        Text("filter_farthest".localized)
                    })
                } label: {
                    Text("filter_upcoming_event".localized)
                }
                
                Button(action: {
                    withAnimation(.smooth) {
                        viewModel.filterSelected = .tags
                    }
                }, label: {
                    Text("word_category".localized)
                })
            } label: {
                Text(viewModel.filterSelected.description)
                    .font(.system(size: 12, weight: .semibold))
                
                switch viewModel.filterSelected {
                case .eventToCome:
                    Image(systemName: viewModel.eventToCome ? "arrow.up" : "arrow.down")
                        .font(.system(size: 10, weight: .semibold))
                case .alphabetic:
                    Image(systemName: viewModel.alphabeticOrder ? "arrow.up" : "arrow.down")
                        .font(.system(size: 10, weight: .semibold))
                case .tags:
                    EmptyView()
                }
            }
            .tint(Color(uiColor: .gray))
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.Apple.backgroundComponent)
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview(traits: .sizeThatFitsLayout) {
    FilterToolbar()
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity)
        .padding()
}
