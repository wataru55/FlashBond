//
//  AuthService.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User? //Firebaseのユーザ認証に用いられる変数
    @Published var currentUser: User?

    static let shared = AuthService() //シングルトンインスタンス

    @MainActor
    // Firebase Authenticationに新規ユーザを登録する関数
    func createUser(email: String, password: String, username: String) async throws {
        do {
            // FirebaseAuthenticationに新規ユーザを登録
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // アプリにログインするために新規登録されたユーザーの情報をuserSessionに格納
            self.userSession = result.user
            // Firestore Databaseにも新規登録したユーザーの情報を追加する
            await uploadUserData(uid: result.user.uid, username: username, email: email)

        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }

    // Firestore Databaseにユーザ情報を追加する関数
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user

        do {
            // ユーザ情報をJSONデータにエンコードしてencodedUserに格納
            let encodedUser = try Firestore.Encoder().encode(user)
            // encodedUser(JSONデータ？)をドキュメントに書き込む
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG: Failed to upload user data with error \(error.localizedDescription)")
        }
    }
}
