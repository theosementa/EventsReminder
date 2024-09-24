//
//  CreateNewEventView.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI
import TheoKit

struct CreateNewEventView: View {
    
    // Builder
    @Binding var viewModel: CreateNewEventViewModel
    
    // Repository
    @State private var tagRepository = TagRepository.shared
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            EmojiTextField(text: $viewModel.emoji)
                                .frame(width: 24, height: 24)
                                .backgroundComponent(isInSheet: true)
                            
                            TextField("createEvent_name".localized, text: $viewModel.name)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .backgroundComponent(isInSheet: true)
                        }
                        
                        NavigationLink {
                            ListOfTagsView(tag: $viewModel.tag)
                        } label: {
                            HStack {
                                Text("word_category".localized)
                                    .fontWeight(.medium)
                                Spacer()
                                if let tag = viewModel.tag {
                                    Text(tag.name)
                                        .foregroundStyle(tag.color.toColor())
                                        .padding(6)
                                        .background {
                                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                                .fill(tag.color.toColor().opacity(0.3))
                                        }
                                }
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(Color(uiColor: .label))
                            .backgroundComponent(isInSheet: true)
                        }

                    }
                    
                    VStack {
                        Text("word_date".localized.uppercased())
                            .font(.system(size: 14, weight: .heavy))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        VStack(spacing: 16) {
                            DatePicker("", selection: $viewModel.date, displayedComponents: viewModel.allDay ? .date : [.hourAndMinute, .date])
                                .padding(8)
                                .backgroundComponent(isInSheet: true, padding: 0)
                            
                            Toggle(isOn: $viewModel.allDay, label: {
                                Text("createEvent_allday".localized)
                            })
                            .padding(10)
                            .backgroundComponent(isInSheet: true, padding: 0)
                            
                            HStack {
                                Text("word_repeat".localized)
                                
                                Spacer()
                                
                                Picker("", selection: $viewModel.repeatType) {
                                    ForEach(Repeat.allCases, id: \.self) {
                                        Text($0.description)
                                    }
                                }
                            }
                            .padding(10)
                            .backgroundComponent(isInSheet: true, padding: 0)
                        }
                        .fontWeight(.medium)
                    }
                }
                .padding()
            } // End ScrollView
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.hidden)
            .navigationTitle(viewModel.event.isNotNil() ? "createEvent_title_edit".localized : "createEvent_title_new".localized.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        Text("word_cancel".localized)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if let event = viewModel.event {
                            viewModel.updateEvent(event)
                        } else {
                            viewModel.createNewEvent()
                        }
                        dismiss()
                    }, label: {
                        Text("word_save".localized)
                    })
                    .disabled(!viewModel.canEventBeCreated())
                }
            }
        } // End NavigationStack
        .interactiveDismissDisabled(viewModel.isEventInCreation()) {
            viewModel.presentingConfirmationDialog.toggle()
        }
        .confirmationDialog("", isPresented: $viewModel.presentingConfirmationDialog) {
            Button("word_discard_changes".localized, role: .destructive, action: { dismiss() })
            Button("word_back".localized, role: .cancel, action: { })
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    Text("HEHO")
        .sheet(isPresented: .constant(true)) {
            CreateNewEventView(viewModel: .constant(.init()))
            .preferredColorScheme(.dark)
    }
}
