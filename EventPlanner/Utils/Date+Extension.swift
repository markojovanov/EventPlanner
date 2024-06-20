//
//  Date+Extension.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 20.6.24.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
