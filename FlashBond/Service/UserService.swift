//
//  UserService.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/15.
//

import SwiftUI
import Firebase

struct UserService {
    static func fetchUserData(uid: String) async throws -> User {
        // ユーザidを使用してFirestoreDatabaseからドキュメントを取得
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        // snapshotからUser型にデータをデコードして値を返す
        return try snapshot.data(as: User.self)
    }
}
