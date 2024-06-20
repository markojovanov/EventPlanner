//
//  UpcomingEventsViewModel.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

class UpcomingEventsViewModel: ObservableObject {
    @Published var events: [UpcomingEvent] = []
    private let apiKey = "BSrHuJ8f1oz86qArPOKQgxqhvXXCGUsbuw0XIb_a"

    func fetchEvents() {
        let urlString = "https://api.predicthq.com/v1/events/?country=MK&limit=10"
        guard let url = URL(string: urlString) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EventResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.events = response.results
                    }
                } catch {
                    print("Error decoding event data: \(error)")
                }
            } else if let error = error {
                print("Error fetching events: \(error.localizedDescription)")
            }
        }.resume()
    }
}
