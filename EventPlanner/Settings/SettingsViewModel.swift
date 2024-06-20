//
//  SettingsViewModel.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 20.6.24.
//

import LocalAuthentication
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var showPaymentOptionsView = false
    @Published var userLikesApp = UserDefaults.standard.bool(forKey: "UserLikesApp")

    func showPaymentOptions() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Show payment options"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        self.showPaymentOptionsView = true
                    }
                }
            }
        }
    }

    func toggleUserLikesApp() {
        UserDefaults.standard.set(userLikesApp, forKey: "UserLikesApp")
    }
}
