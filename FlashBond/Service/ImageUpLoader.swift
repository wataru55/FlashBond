//
//  ImageLoader.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/14.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ImageUpLoader {
    /// 画像データをFirebase Storageに保存してそのダウンロードURLを返す関数
    static func uploadImageToStorage(image: UIImage) async throws -> String? {
        // UIImageをJPEG形式のバイナリデータに変換
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
        // ファイル名としてUUIDを生成
        let filename = NSUUID().uuidString
        // Firebase Storageの参照を作成し, 保存先のパスを指定
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")

        // Firebase Storageに保存する際のメタデータを設定
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // 認証されたユーザーのUIDを取得して, authorIdとしてメタデータに追加
        if let uid = AuthService.shared.currentUser?.id {
            metadata.customMetadata = ["authorId": uid]  // ここでUIDを設定
        } else {
            print("DEBUG: Failed to get current user's UID.")
            return nil
        }

        do {
            // 画像データをStorageに保存する関数
            let _ = try await storageRef.putDataAsync(imageData, metadata: metadata)
            // 保存が成功したらダウンロードURLを取得して, 文字列を返す
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            // エラーが発生した場合、エラーメッセージを出力してnilを返す
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}

