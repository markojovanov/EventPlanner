//
//  GeneralButton.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

struct GeneralButton: View {
    var title: String
    var color: Color
    var action: () -> ()

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }
    }
}

#Preview {
    GeneralButton(title: "Add picture", color: .green, action: {})
}
