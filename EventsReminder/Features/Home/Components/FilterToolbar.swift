//
//  FilterToolbar.swift
//  EventsReminder
//
//  Created by Theo Sementa on 13/05/2024.
//

import SwiftUI

struct FilterToolbar: View {
    
    // Custom
    @EnvironmentObject private var filterManager: FilterManager
    
    // MARK: -
    var body: some View {
        HStack {
            Menu {
                ForEach(EventStatus.allCases, id: \.self) { status in
                    Button { filterManager.eventStatus = status } label: {
                        Text(status.description)
                    }
                }
            } label: {
                Text(filterManager.eventStatus.description)
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
                        filterManager.filterSelected = .alphabetic
                        filterManager.alphabeticOrder = true
                    }, label: {
                        Text("A -> Z")
                    })
                    Button(action: {
                        filterManager.filterSelected = .alphabetic
                        filterManager.alphabeticOrder = false
                    }, label: {
                        Text("Z -> A")
                    })
                } label: {
                    Text("filter_alphabetic".localized)
                }
                
                Menu {
                    Button(action: {
                        filterManager.filterSelected = .eventToCome
                        filterManager.eventToCome = true
                    }, label: {
                        Text("filter_nearest".localized)
                    })
                    Button(action: {
                        filterManager.filterSelected = .eventToCome
                        filterManager.eventToCome = false
                    }, label: {
                        Text("filter_farthest".localized)
                    })
                } label: {
                    Text("filter_upcoming_event".localized)
                }
                
                Button(action: {
                    withAnimation(.smooth) {
                        filterManager.filterSelected = .tags
                    }
                }, label: {
                    Text("word_category".localized)
                })
            } label: {
                Text(filterManager.filterSelected.description)
                    .font(.system(size: 12, weight: .semibold))
                
                switch filterManager.filterSelected {
                case .eventToCome:
                    Image(systemName: filterManager.eventToCome ? "arrow.up" : "arrow.down")
                        .font(.system(size: 10, weight: .semibold))
                case .alphabetic:
                    Image(systemName: filterManager.alphabeticOrder ? "arrow.up" : "arrow.down")
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
