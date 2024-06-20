//
//  ContentView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var timer: Timer?

    var body: some View {
        TabView {
            MyEventsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Events")
                }
            UpcomingEventsView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Upcoming")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .onAppear {
            scheduleRepeatingNotifications()
        }
    }

    func scheduleRepeatingNotifications() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            sendNotification()
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

#Preview {
    ContentView()
}
