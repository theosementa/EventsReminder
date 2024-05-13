//
//  CreateNewEventView.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import SwiftUI

struct CreateNewEventView: View {
    
    // Custom
    @State private var viewModel = CreateNewEventViewModel()
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
                            
                            TextField("Name of the event", text: $viewModel.name)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .backgroundComponent(isInSheet: true)
                        }
                        
                        NavigationLink {
                            ListOfTags(tag: $viewModel.tag)
                        } label: {
                            HStack {
                                Text("Tag")
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
                        Text("DATE")
                            .font(.system(size: 14, weight: .heavy))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        VStack(spacing: 16) {
                            DatePicker("", selection: $viewModel.date, displayedComponents: viewModel.allDay ? .date : [.hourAndMinute, .date])
                                .padding(8)
                                .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                            
                            Toggle(isOn: $viewModel.allDay, label: {
                                Text("All the day")
                            })
                            .padding(10)
                            .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                            
                            HStack {
                                Text("Repeat")
                                
                                Spacer()
                                
                                Picker("", selection: $viewModel.repeatType) {
                                    ForEach(Repeat.allCases, id: \.self) {
                                        Text($0.description)
                                    }
                                }
                            }
                            .padding(10)
                            .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                        }
                        .fontWeight(.medium)
                    }
                    
                    VStack {
                        Text("NOTIFICATIONS")
                            .font(.system(size: 14, weight: .heavy))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        NavigationLink {
                            VStack(spacing: 16) {
                                Toggle(isOn: $viewModel.notifOneDayBefore, label: {
                                    Text("1 day before")
                                })
                                .padding(10)
                                .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                                
                                Toggle(isOn: $viewModel.notifThreeDayBefore, label: {
                                    Text("3 days before")
                                })
                                .padding(10)
                                .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                                
                                Toggle(isOn: $viewModel.notifOneWeekBefore, label: {
                                    Text("1 week before")
                                })
                                .padding(10)
                                .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                                
                                Toggle(isOn: $viewModel.notifOneMonthBefore, label: {
                                    Text("1 month before")
                                })
                                .padding(10)
                                .backgroundComponent(isInSheet: true, isPaddingEnabled: false)
                                
                                Spacer()
                            }
                            .padding()
                        } label: {
                            HStack {
                                Text("Notifications")
                                Spacer()
                                Text(viewModel.nbrNotifs.formatted())
                                Image(systemName: "chevron.right")
                            }
                            .backgroundComponent(isInSheet: true)
                            .foregroundStyle(Color(uiColor: .label))
                            .fontWeight(.medium)
                        }
                        
                    }
                }
                .padding()
            } // End ScrollView
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.hidden)
            .navigationTitle("New event".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        Text("Cancel".localized)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if viewModel.canEventBeCreated() {
                            viewModel.createNewEvent()
                            dismiss()
                        }
                    }, label: {
                        Text("Save".localized)
                    })
                    .disabled(!viewModel.canEventBeCreated())
                }
            }
        } // End NavigationStack
        .interactiveDismissDisabled(viewModel.isEventInCreation()) {
            viewModel.presentingConfirmationDialog.toggle()
        }
        .confirmationDialog("", isPresented: $viewModel.presentingConfirmationDialog) {
            Button("Discard changes".localized, role: .destructive, action: { dismiss() })
            Button("Back".localized, role: .cancel, action: { })
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    Text("HEHO")
        .sheet(isPresented: .constant(true)) {
        CreateNewEventView()
            .preferredColorScheme(.dark)
    }
}
