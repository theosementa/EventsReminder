//
//  Tag+CoreDataProperties.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(TagEntity)
public class TagEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged private var colorData: Data
    @NSManaged public var events: Set<EventEntity>?
    
    public var color: Color {
        get {
            do {
                return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)!)
            } catch {
                print(error)
            }
            
            return Color.clear
        }
        set {
            do {
                try colorData = NSKeyedArchiver.archivedData(withRootObject: UIColor(newValue), requiringSecureCoding: false)
            } catch {
                print(error)
            }
        }
    }

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

// MARK: - Preview
extension TagEntity {
    
    static var preview1: TagEntity {
        let preview = TagEntity(context: CoreDataStack.preview.viewContext)
        preview.id = UUID()
        preview.name = "Prev TAG 1"
        preview.color = .blue
        
        return preview
    }
    
}
