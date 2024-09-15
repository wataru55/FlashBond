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

    @MainActor
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

    // ログインする関数
    @MainActor
    func signin(email: String, password: String) async throws {
        do {
            // Firebase Authenticationでログイン
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // ログインしたユーザー情報をuserSessionに格納
            self.userSession = result.user
            // ログインしたユーザーの情報をFirestore Databaseから取得
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error  // エラーを再スロー
        }
    }

    @MainActor
    func loadUserData() async throws {
        //currentUserのユーザidを取得し，currentUidに格納
        guard let currentUid = userSession?.uid else { return }
        //currentUidを使用してFirestoreDatabaseからユーザーの情報を取得
        self.currentUser = try await UserService.fetchUserData(uid: currentUid)
    }

    // ログアウトする関数
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
