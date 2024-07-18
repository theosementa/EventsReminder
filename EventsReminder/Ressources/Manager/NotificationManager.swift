//
//  NotificationManager.swift
//  EventsReminder
//
//  Created by KaayZenn on 16/05/2024.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    let center = UNUserNotificationCenter.current()

}

extension NotificationManager {
    
    func createNotifications(event: EventEntity) async {        
        do {
            let isAuthorized = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            
            if isAuthorized {
                scheduleNotification(
                    event: event,
                    dateComponents: event.date.toDateComponents(isForNotification: event.date.isMidnight()),
                    daysRemaining: 0
                )
                
                if let dateOneDayAgo = event.date.oneDayAgo(forNotification: true), dateOneDayAgo > .now {
                    scheduleNotification(
                        event: event,
                        dateComponents: dateOneDayAgo.toDateComponents(isForNotification: true),
                        daysRemaining: 1
                    )
                }
                
                if let dateOneWeekAgo = event.date.oneWeekAgo(forNotification: true), dateOneWeekAgo > .now {
                    scheduleNotification(
                        event: event,
                        dateComponents: dateOneWeekAgo.toDateComponents(isForNotification: true),
                        daysRemaining: 7
                    )
                }
            }
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    private func scheduleNotification(event: EventEntity, dateComponents: DateComponents, daysRemaining: Int) {
        var displayedBody: String {
            if daysRemaining > 1 {
                let daysOrDay = daysRemaining == 1 ? "word_day".localized : "word_days".localized
                return event.name + " \("word_in".localized) " + "\(daysRemaining) \(daysOrDay)"
            } else {
                return event.name + " " + "word_today".localized
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Events Reminder"
        content.body = displayedBody
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: event.id.uuidString + UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}
