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
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        guard let uid = AuthService.shared.currentUser?.id else { return nil}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(uid)/\(filename)")

        // コンテンツタイプを設定
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        do {
            let _ = try await ref.putDataAsync(imageData, metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
