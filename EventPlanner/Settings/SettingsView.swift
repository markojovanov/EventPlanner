//
//  SettingsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        VStack {
            toggleView
                .padding()
            GeneralButton(title: "Show payment options", color: .red) {
                viewModel.showPaymentOptions()
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Settings")
        .navigate(isActive: $viewModel.showPaymentOptionsView) {
            PaymentOptionsView()
        }
        .navigationViewWrapped()
    }

    private var toggleView: some View {
        Section {
            Toggle(isOn: $viewModel.userLikesApp) {
                HStack {
                    Text("Do you like the application")
                    Spacer()
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .onChange(of: viewModel.userLikesApp) { _, _ in
                viewModel.toggleUserLikesApp()
            }
        }
    }
}

#Preview {
    SettingsView()
}
