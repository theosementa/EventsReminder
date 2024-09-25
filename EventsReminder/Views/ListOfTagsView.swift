//
//  ListOfTagsView.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import SwiftUI

struct ListOfTagsView: View {
    
    // Builder
    @Binding var tag: TagEntity?
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tagRepository: TagRepository
    
    // String variables
    @State private var searchText: String = ""
    
    // Bool variables
    @State private var showAddTag: Bool = false
    
    // Computed variables
    var searchResults: [TagEntity] {
        if searchText.isEmpty {
            return tagRepository.tags
        } else {
            return tagRepository.tags.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    // MARK: -
    var body: some View {
        List {
            ForEach(searchResults) { tag in
                TagCell(tag: tag, action: {
                    self.tag = tag
                    dismiss()
                })
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 6, leading: 16, bottom: 12, trailing: 16))
                .listRowBackground(Color.clear.edgesIgnoringSafeArea(.all))
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .overlay {
            if tagRepository.tags.isEmpty {
                Text("listOfTags_add_first_tag".localized)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .sheet(isPresented: $showAddTag, content: {
            CreateNewTagView()
        })
        .searchable(text: $searchText.animation(), prompt: "listOfTags_search".localized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("listOfTags_title".localized)
        .toolbar {
            Button(action: { showAddTag.toggle() }, label: {
                Image(systemName: "plus")
            })
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    ListOfTagsView(tag: .constant(.preview1))
}
