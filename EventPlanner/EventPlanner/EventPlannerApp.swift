//
//  EventPlannerApp.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import SwiftData
import SwiftUI

@main
struct EventPlannerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    appDelegate.requestNotificationAuthorization()
                }
        }
        .modelContainer(DataModel.shared.modelContainer)
    }
}
