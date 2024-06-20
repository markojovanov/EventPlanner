//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftData
import SwiftUI

struct MyEventsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var myEvents: [MyEventDetails]

    var body: some View {
        List {
            ForEach(myEvents) { myEvent in
                NavigationLink {
                    MyEventDetailsView(event: myEvent)
                } label: {
                    VStack(alignment: .leading) {
                        Text(myEvent.name)
                            .font(.headline)
                            .bold()
                        Text(myEvent.information)
                            .font(.caption)
                    }
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
    MyEventsView()
        .modelContainer(for: MyEventDetails.self, inMemory: true)
}
