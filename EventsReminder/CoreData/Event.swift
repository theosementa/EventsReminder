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
    @NSManaged private var dateEvent: Date?
    @NSManaged private var repeatEnum: Int16
    @NSManaged public var tag: TagEntity?
    
    public var date: Date {
        get {
            if let dateEvent {
                return dateEvent
            } else {
                return .now
            }
        }
        set {
            dateEvent = newValue
        }
    }
    
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
        return start.daysBetween(to: end) ?? 0
    }
    
    public var fullDate: String {
        var dateFormat: String {
            if Locale.current.identifier.contains("en") {
                return "E d MMMM yyyy" + (date.isMidnight() ? "" : ", h:mm a")
            } else {
                return "E d MMMM yyyy" + (date.isMidnight() ? "" : ", HH:mm")
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

}

// MARK: - Helper
extension EventEntity {
    
    func toEventForWidget() -> EventForWidget {
        return EventForWidget(identifier: self.id.uuidString, display: self.name)
    }
    
}

// MARK: - Preview
extension EventEntity {
    
    static var preview1: EventEntity {
        let preview = EventEntity(context: CoreDataStack.shared.viewContext)
        preview.id = UUID()
        preview.name = "Preview 1"
        preview.emoji = "🎂"
        preview.dateEvent = Calendar.current.date(byAdding: .day, value: 10, to: .now) ?? .now
        preview.repeatType = .yearly
        
        return preview
    }
    
}
