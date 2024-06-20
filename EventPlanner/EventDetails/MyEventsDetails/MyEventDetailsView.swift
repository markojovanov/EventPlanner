//
//  MyEventDetailsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import CoreLocation
import SwiftUI

struct MyEventDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showCameraView = false
    @State private var imageData: Data?
    @Bindable var event: MyEventDetails

    var body: some View {
        EventDetailsView(
            title: event.name,
            description: event.information,
            startTimeString: event.startTime,
            eventLocation: event.location,
            cameraButtonAction: { showCameraView = true },
            mainButtonTitle: "Delete from my events",
            mainButtonColor: .red,
            mainButtonAction: { deleteEvent(event) },
            imageData: event.picture
        )
        .onAppear {
            if let imageData {
                updateEvent(event, with: imageData)
            }
        }
        .navigationTitle("Event details")
        .navigate(isActive: $showCameraView) {
            CameraView(imageData: $event.picture)
        }
    }

    private func deleteEvent(_ event: MyEventDetails) {
        withAnimation {
            modelContext.delete(event)
        }
        dismiss()
    }

    private func updateEvent(_ event: MyEventDetails, with imageData: Data?) {
        withAnimation {
            event.picture = imageData
        }
    }
}

#Preview {
    MyEventDetailsView(
        event: MyEventDetails(
            name: "New event - Skopje",
            information: "Sport match",
            location: [
                21.425689,
                42.005793
            ],
            startTime: "2024-09-10T18:45:00Z"
        )
    )
    .modelContainer(for: MyEventDetails.self, inMemory: true)
}
