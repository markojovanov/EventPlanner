//
//  UpcomingEventsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import Shimmer
import SwiftUI

struct UpcomingEventsView: View {
    @StateObject private var viewModel = UpcomingEventsViewModel()

    var body: some View {
        Group {
            if viewModel.events.isEmpty {
                placeholder
            } else {
                upcomingEvents
            }
        }
        .onAppear {
            viewModel.fetchEvents()
        }
        .navigationTitle("Upcoming")
        .navigationViewWrapped()
    }

    private var placeholder: some View {
        List {
            ForEach(0 ..< 8) { _ in
                EventListItem(
                    title: "Upcoming event",
                    description: "Wait for it....",
                    startTime: "In a minute"
                )
            }
        }
        .shimmering()
    }

    private var upcomingEvents: some View {
        List {
            ForEach(viewModel.events) { event in
                NavigationLink {
                    UpcomingEventDetails(event: event)
                } label: {
                    EventListItem(
                        title: event.title,
                        description: event.description,
                        startTime: event.start
                    )
                }
            }
        }
    }
}

#Preview {
    UpcomingEventsView()
}
