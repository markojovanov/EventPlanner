//
//  WrappedNavigation.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

public extension View {
    func navigationViewWrapped() -> some View {
        modifier(NavigationViewWrappedModifier())
    }
}

// MARK: - NavigationViewWrappedModifier

public struct NavigationViewWrappedModifier: ViewModifier {
    @ViewBuilder public func body(content: Content) -> some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                .background(.linearGradient(
                    Gradient(colors: [.red, .orange]),
                    startPoint: .top,
                    endPoint: .bottomLeading)
                )
                content
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
