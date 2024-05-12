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

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var emoji: String
    @NSManaged public var date: Date
    @NSManaged private var repeatEnum: Int16
    @NSManaged public var tag: TagEntity?
    
    public var repeatType: Repeat {
        get {
            return Repeat(rawValue: Int(repeatEnum)) ?? .none
        }
        set {
            repeatEnum = Int16(newValue.rawValue)
        }
    }
    
    public var daysRemaining: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: .now)
        let end = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        if let days = components.day {
            return days
        } else {
            return 0
        }
    }

}

// MARK: - Preview
extension EventEntity {
    
    static var preview1: EventEntity {
        let preview = EventEntity(context: CoreDataStack.preview.viewContext)
        preview.id = UUID()
        preview.name = "Preview 1"
        preview.emoji = "🎂"
        preview.date = Calendar.current.date(byAdding: .day, value: 10, to: .now) ?? .now
        preview.repeatType = .yearly
        
        return preview
    }
    
}
