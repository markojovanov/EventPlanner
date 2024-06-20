//
//  DataModel.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftData
import SwiftUI

actor DataModel {
    static let shared = DataModel()
    private init() {}

    nonisolated lazy var modelContainer: ModelContainer = {
        let schema = Schema([MyEventDetails.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
