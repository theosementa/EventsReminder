//
//  EventUpdateModel.swift
//  EventsReminder
//
//  Created by Theo Sementa on 23/01/2025.
//

import Foundation

struct EventUpdateModel {
    var event: EventEntity
    var name: String
    var date: Date
    var repeatType: Repeat
    var tag: TagEntity?
}
