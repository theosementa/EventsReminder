//
//  ListOfTags.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import SwiftUI

struct ListOfTags: View {
    
    // Builder
    @Binding var tag: TagEntity?
    
    // Custom
    @State private var tagRepository = TagRepository.shared
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // Bool variables
    @State private var showAddTag: Bool = false
    
    // MARK: -
    var body: some View {
        List {
            ForEach(tagRepository.tags, id: \.self) { tag in
                Button {
                    self.tag = tag
                    dismiss()
                } label: {
                    Text(tag.name)
                        .foregroundStyle(tag.color.toColor())
                        .fontWeight(.semibold)
                        .padding(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .backgroundComponent(
                            containerColor: tag.color.toColor().opacity(0.3),
                            strokeColor: tag.color.toColor()
                        )
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(Color.clear.edgesIgnoringSafeArea(.all))

            }
        }
        .listStyle(.plain)
        .sheet(isPresented: $showAddTag, content: {
            CreateNewTagView()
        })
        .toolbar {
            Button(action: { showAddTag.toggle() }, label: {
                Image(systemName: "plus")
            })
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    ListOfTags(tag: .constant(.preview1))
}
