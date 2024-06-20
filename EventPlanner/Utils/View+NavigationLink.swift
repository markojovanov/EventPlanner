//
//  View+NavigationLink.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func navigate<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        background(NavigationLink(destination: destination(),
                                  isActive: isActive,
                                  label: EmptyView.init))
    }
}
