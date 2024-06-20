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
            ForEach(0 ..< 5) { _ in
                VStack(alignment: .leading) {
                    Text("Upcoming event")
                        .font(.headline)
                        .bold()
                    Text("***********************")
                        .font(.caption)
                }
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
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.headline)
                            .bold()
                        Text(event.description)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    UpcomingEventsView()
}
