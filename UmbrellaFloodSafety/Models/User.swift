//
//  User.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import Foundation

struct User: Codable {
    let id: String
    let username: String
    let name: String
    let joined: TimeInterval
    let isChild: Bool
}
