//
//  CreateNewTagView.swift
//  EventsReminder
//
//  Created by KaayZenn on 13/05/2024.
//

import SwiftUI

struct CreateNewTagView: View {
    
    // Custom
    @State private var viewModel = CreateNewTagViewModel()
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 16) {
                    ColorPicker("", selection: $viewModel.color)
                        .frame(width: 24, height: 24)
                        .labelsHidden()
                        .backgroundComponent(isInSheet: true)
                    
                    TextField("createTag_name", text: $viewModel.name)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .backgroundComponent(isInSheet: true)
                }
                
                Spacer()
            } // End VStack
            .padding()
            .navigationTitle("createTag_title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        Text("word_cancel".localized)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if viewModel.canTagBeCreated() {
                            viewModel.createNewTag()
                            dismiss()
                        }
                    }, label: {
                        Text("word_save".localized)
                    })
                    .disabled(!viewModel.canTagBeCreated())
                }
            }
        } // End NavigationStack
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    Text("HEHO")
        .sheet(isPresented: .constant(true)) {
            CreateNewTagView()
                .presentationDetents([.medium])
                .preferredColorScheme(.dark)
    }
}
