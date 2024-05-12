//
//  Tag+CoreDataProperties.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//
//

import Foundation
import CoreData

@objc(TagEntity)
public class TagEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var events: Set<EventEntity>?

}

// MARK: Generated accessors for events
extension TagEntity {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: EventEntity)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: EventEntity)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
