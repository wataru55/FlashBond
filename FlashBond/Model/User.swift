//
//  User.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/10.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var email: String
    var profileImageUrl: String?
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "ironman", profileImageUrl: "ironman1", email: "ironman@gmail.com"),
    ]
}

