//
//  ContentView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import SwiftUI

struct ContentView: View {
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
    }
}

#Preview {
    ContentView()
}
