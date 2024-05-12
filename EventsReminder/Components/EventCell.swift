//
//  EventCell.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI

struct EventCell: View {
    
    // Builder
    @ObservedObject var event: EventEntity
    
    // MARK: -
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    EventCell(event: .preview1)
}
