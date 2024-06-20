//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftData
import SwiftUI

struct MyEventsView: View {
    @StateObject private var viewModel = MyEventsViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var myEvents: [MyEventDetails]

    var body: some View {
        List {
            ForEach(myEvents) { myEvent in
                NavigationLink {
                    MyEventDetailsView(event: myEvent)
                } label: {
                    EventListItem(
                        title: myEvent.name,
                        description: myEvent.information,
                        startTime: myEvent.startTime
                    )
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .foregroundColor(.black)
            }
        }
        .navigationTitle("My Events")
        .onAppear {
            viewModel.requestNotificationAuthorization()
        }
        .navigationViewWrapped()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(myEvents[index])
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MyEventDetails.self, configurations: config)

    for i in 1 ..< 10 {
        let user = MyEventDetails(
            name: "New event - Skopje",
            information: "Sport match",
            location: [
                21.425689,
                42.005793
            ],
            startTime: "2024-09-10T18:45:00Z"
        )
        container.mainContext.insert(user)
    }

    return MyEventsView()
        .modelContainer(container)
}
