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
    var imageURL: String?
    var bio: String?
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "ironman", email: "ironman@gmail.com", imageURL: "ironman1"),
    ]
}

