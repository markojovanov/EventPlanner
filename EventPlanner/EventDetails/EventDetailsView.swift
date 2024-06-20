//
//  EventDetailsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 20.6.24.
//

import CoreLocation
import SwiftUI

struct EventDetailsView: View {
    let isoFormatter = ISO8601DateFormatter()
    @State private var showMap = false
    @State private var location: CLLocationCoordinate2D?

    var title: String
    var description: String
    var startTimeString: String
    var eventLocation: [Double]
    var cameraButtonAction: (() -> ())?
    var mainButtonTitle: String
    var mainButtonColor: Color
    var mainButtonAction: () -> ()
    var imageData: Data?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)

                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)

                if let startDate = isoFormatter.date(from: startTimeString) {
                    Text("Start date: \(startDate.formatDate())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .padding(.bottom, 20)
                }

                HStack(spacing: 20) {
                    if let cameraButtonAction = cameraButtonAction {
                        GeneralButton(
                            title: "Add picture",
                            color: .blue,
                            action: cameraButtonAction
                        )
                    }
                    GeneralButton(
                        title: "Show in map",
                        color: .green,
                        action: showMapView
                    )
                }
                .padding(.top, 10)

                GeneralButton(
                    title: mainButtonTitle,
                    color: mainButtonColor,
                    action: mainButtonAction
                )
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            .padding()
        }
        .navigate(isActive: $showMap) {
            EventMapLocationView(selectedLocation: $location)
        }
    }

    private func showMapView() {
        if eventLocation.count == 2 {
            location = CLLocationCoordinate2D(latitude: eventLocation[1], longitude: eventLocation[0])
            showMap = true
        }
    }
}

#Preview {
    EventDetailsView(
        title: "Macedonia - Germany football",
        description: "Nice match of the euros, located in Skopje. There will be around 50,000 people in the standing, which means it will have a nice atmosphere.",
        startTimeString: "2024-09-10T18:45:00Z",
        eventLocation: [
            21.425689,
            42.005793
        ],
        cameraButtonAction: {},
        mainButtonTitle: "Add item",
        mainButtonColor: .black,
        mainButtonAction: {}
    )
}
