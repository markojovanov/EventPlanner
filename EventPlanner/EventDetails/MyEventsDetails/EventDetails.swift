//
//  EventDetails.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import CoreLocation
import SwiftUI

struct MyEventDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showMap = false
    @State private var showCameraView = false
    @State private var location: CLLocationCoordinate2D?
    @State private var imageData: Data?
    let isoFormatter = ISO8601DateFormatter()
    var event: MyEventDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(event.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 5)

            Text(event.information)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            if let startDate = isoFormatter.date(from: event.startTime) {
                Text("Start date: \(startDate.formatDate())")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            HStack(spacing: 20) {
                GeneralButton(title: "Add picture", color: .blue) {
                    showCameraView = true
                }
                GeneralButton(title: "Show in map", color: .green) {
                    showMapView()
                }
            }
            .padding(.top, 10)
            GeneralButton(title: "Delete from my events", color: .red) {
                deleteEvent(event)
            }
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
        .padding()
        .onAppear {
            if let imageData {
                updateEvent(event, with: imageData)
            }
            self.imageData = event.picture
        }
        .navigate(isActive: $showMap) {
            MapView(selectedLocation: $location)
        }
        .navigate(isActive: $showCameraView) {
            CameraView(imageData: $imageData)
        }
    }

    private func showMapView() {
        if event.location.count == 2 {
            location = CLLocationCoordinate2D(latitude: event.location[1], longitude: event.location[0])
            showMap = true
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
            let newEvent = MyEventDetails(
                name: event.name,
                information: event.name,
                location: event.location,
                startTime: event.startTime,
                picture: imageData
            )
            modelContext.insert(newEvent)
            modelContext.delete(event)
        }
    }
}
