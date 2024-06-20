//
//  MyEventDetails.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 17.6.24.
//

import Foundation
import SwiftData

@Model
final class MyEventDetails {
    var name: String
    var information: String
    var location: [Double]
    var startTime: String
    var picture: Data?

    init(name: String, information: String, location: [Double], startTime: String, picture: Data? = nil) {
        self.name = name
        self.information = information
        self.location = location
        self.startTime = startTime
        self.picture = picture
    }
}
