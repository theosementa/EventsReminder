//
//  EventCreationModel.swift
//  EventsReminder
//
//  Created by Theo Sementa on 23/01/2025.
//

import Foundation

struct EventCreationModel {
    var name: String
    var date: Date
    var repeatType: Repeat
    var tag: TagEntity?
}
