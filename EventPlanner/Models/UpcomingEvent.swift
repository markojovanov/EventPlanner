//
//  UpcomingEvent.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import Foundation

// MARK: - UpcomingEvent

struct UpcomingEvent: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let location: [Double]
    let start: String
}

// MARK: - UpcomingEventsResponse

struct UpcomingEventsResponse: Codable {
    let results: [UpcomingEvent]
}
