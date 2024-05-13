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
    
    public var color: UIColor {
        get {
            do {
                return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)!
            } catch {
                print(error)
            }
            
            return UIColor(Color.clear)
        }
        set {
            do {
                try colorData = NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false)
            } catch {
                print(error)
            }
        }
    }

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
