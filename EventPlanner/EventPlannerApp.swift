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
        }
        .modelContainer(DataModel.shared.modelContainer)
    }
}
