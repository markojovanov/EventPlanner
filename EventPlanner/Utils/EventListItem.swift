//
//  EventListItem.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 20.6.24.
//

import SwiftUI

struct EventListItem: View {
    let isoFormatter = ISO8601DateFormatter()

    var title: String
    var description: String
    var startTime: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .bold()
            Text(description)
                .font(.caption)
            if let startDate = isoFormatter.date(from: startTime) {
                Text("Start date: \(startDate.formatDate())")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    EventListItem(
        title: "New event - Skopje",
        description: "Sport match",
        startTime: "2024-09-10T18:45:00Z"
    )
}
