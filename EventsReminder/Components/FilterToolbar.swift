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
                    .fill(Color.backgroundComponent)
            }
            
            Spacer()
            
            Menu {
                Menu {
                    Button(action: {
                        viewModel.filterSelected = .alphabetic
                        viewModel.alphabeticOrder = false
                    }, label: {
                        Text("Z -> A")
                    })
                    
                    Button(action: {
                        viewModel.filterSelected = .alphabetic
                        viewModel.alphabeticOrder = true
                    }, label: {
                        Text("A -> Z")
                    })
                } label: {
                    Text("Alphabetic")
                }
                
                Menu {
                    Button(action: {
                        viewModel.filterSelected = .eventToCome
                        viewModel.eventToCome = true
                    }, label: {
                        Text("Nearest first")
                    })
                    Button(action: {
                        viewModel.filterSelected = .eventToCome
                        viewModel.eventToCome = false
                    }, label: {
                        Text("Farthest first")
                    })
                } label: {
                    Text("Events to come")
                }
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
                    .fill(Color.backgroundComponent)
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
