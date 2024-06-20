//
//  UpcomingEventDetails.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import CoreLocation
import SwiftUI

struct UpcomingEventDetails: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showMap = false
    @State private var location: CLLocationCoordinate2D?
    let isoFormatter = ISO8601DateFormatter()
    var event: UpcomingEvent

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 5)

            Text(event.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            if let startDate = isoFormatter.date(from: event.start) {
                Text("Start date: \(startDate.formatDate())")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            GeneralButton(title: "Show in map", color: .green) {
                showMapView()
            }
            .padding(.top, 10)
            GeneralButton(title: "Add to my events", color: .black) {
                addToMyEvent(event)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
        .padding()
        .navigate(isActive: $showMap) {
            EventMapLocationView(selectedLocation: $location)
        }
    }

    private func showMapView() {
        if event.location.count == 2 {
            location = CLLocationCoordinate2D(latitude: event.location[1], longitude: event.location[0])
            showMap = true
        }
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
    UpcomingEventDetails(
        event: UpcomingEvent(
            id: "Macedonia - Germany footbal",
            title: "Macedonia - Germany footbal",
            description: "Nice match of the euros, located in Skopje. Ima 50000 posetitieli koi kje navivat za Makedonija da pobedi",
            location: [
                21.425689,
                42.005793
            ],
            start: "2024-09-10T18:45:00Z"
        )
    )
    .modelContainer(for: MyEventDetails.self, inMemory: true)
}
