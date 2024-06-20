//
//  SettingsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import LocalAuthentication
import SwiftUI

// import Lottie

struct SettingsView: View {
    @State private var showNextView = false
    @State private var hasSupportedApp: Bool = UserDefaults.standard.bool(forKey: "HasSupportedApp")

    var body: some View {
        ScrollView {
            GeneralButton(title: "Show payment options", color: .orange) {
                authenticate()
            }
            .padding()
//            LottieButton(animation: .named("test")) {
//                <#code#>
//            }
            Button(action: {
                supportApp()
            }) {
                Text("Support the application")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(hasSupportedApp ? Color.green : Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Settings")
        .navigate(isActive: $showNextView) {
            PaymentOptionsView()
        }
        .navigationViewWrapped()
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID / Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        self.showNextView = true
                    }
                }
            }
        }
    }

    private func supportApp() {
        hasSupportedApp.toggle()
        UserDefaults.standard.set(hasSupportedApp, forKey: "HasSupportedApp")
    }
}

#Preview {
    SettingsView()
}
