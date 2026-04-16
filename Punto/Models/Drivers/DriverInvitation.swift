//
//  Driver.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/04/26.
//

import Foundation

enum invitationStatus: String, Codable {
    case pending = "pending"
    case accepted = "accepted"
    case rejected = "rejected"
}

struct DriverInvitation: Codable {
    var name: String
    var email: String
    var phone: String
    var status: invitationStatus
}
