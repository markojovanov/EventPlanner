//
//  MyEventsViewModel.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 20.6.24.
//

import SwiftUI
import UserNotifications

class MyEventsViewModel: ObservableObject {
    @Published private var timer: Timer?

    func scheduleRepeatingNotifications() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
            self.sendNotification()
        }
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Check for New Events"
        content.body = "It's time to check for new events."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
}
