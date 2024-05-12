//
//  Event+CoreDataProperties.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//
//

import Foundation
import CoreData

@objc(EventEntity)
public class EventEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var emoji: String?
    @NSManaged public var date: Date?
    @NSManaged public var repeatEnum: Int16
    @NSManaged public var tag: TagEntity?

}
