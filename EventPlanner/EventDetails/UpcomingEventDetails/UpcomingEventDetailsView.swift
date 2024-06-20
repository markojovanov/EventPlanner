//
//  UpcomingEventDetailsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

struct UpcomingEventDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var event: UpcomingEvent

    var body: some View {
        EventDetailsView(
            title: event.title,
            description: event.description,
            startTimeString: event.start,
            eventLocation: event.location,
            mainButtonTitle: "Add to my events",
            mainButtonColor: .black,
            mainButtonAction: { addToMyEvent(event) }
        )
        .navigationTitle("Event details")
    }

    private func addToMyEvent(_ event: UpcomingEvent) {
        withAnimation {
            let newItem = MyEventDetails(
                name: event.title,
                information: event.description,
                location: event.location,
                startTime: event.start
            )
            modelContext.insert(newItem)
        }
        dismiss()
    }
}

#Preview {
    UpcomingEventDetailsView(
        event: UpcomingEvent(
            id: "Macedonia - Germany footbal",
            title: "Macedonia - Germany footbal",
            description: "Nice match of the euros, located in Skopje. There will be around 50,000 people in the standing, which means it will have nice atmosphere.",
            location: [
                21.425689,
                42.005793
            ],
            start: "2024-09-10T18:45:00Z"
        )
    )
    .modelContainer(for: MyEventDetails.self, inMemory: true)
}
