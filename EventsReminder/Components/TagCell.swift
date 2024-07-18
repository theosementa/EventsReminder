//
//  TagCell.swift
//  EventsReminder
//
//  Created by KaayZenn on 15/05/2024.
//

import SwiftUI

struct TagCell: View {
    
    // Builder
    var tag: TagEntity
    var action: () -> Void
    
    // Repository
    @State private var tagRepository: TagRepository = .shared
    
    // MARK: -
    var body: some View {
        Button {
            action()
        } label: {
            Text(tag.name)
                .foregroundStyle(tag.color.toColor())
                .fontWeight(.semibold)
                .padding(4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .backgroundComponent(
                    containerColor: tag.color.toColor().opacity(0.2),
                    strokeColor: tag.color.toColor()
                )
        }
        .contextMenu {
            Button(role: .destructive, action: {
                tagRepository.deleteTag(tag)
            }, label: {
                Label("word_delete".localized, systemImage: "trash.fill")
            })
        } preview: {
            self
                .frame(width: UIScreen.main.bounds.width - 32)
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    TagCell(tag: .preview1, action: {})
}
