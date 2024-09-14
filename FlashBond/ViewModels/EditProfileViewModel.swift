//
//  EditProfileViewModel.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/13.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class EditProfileViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var bio: String = ""
    /// ユーザーがPhotsPickerで選択した画像データを格納するプロパティ
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    /// ユーザーが選択した画像をビューに表示するためのプロパティ
    @Published var displayImage: Image?
    // ユーザーにステータスメッセージを表示するためのプロパティ
    @Published var statusMessage: String?
    /// バイナリデータから画像データであるUIImageに変換された値を格納するためのプロパティ
    private var uiImage: UIImage?

    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        // item(選択された画像)がnilでないことを確認
        guard let item = item else { return }
        // 画像データを非同期で取得し、バイナリデータとして読み込む
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        // バイナリデータをUIImageに変換
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.displayImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    func saveProfileToFirestore() async throws {
        // ユーザーIDを取得
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // 画像データを取得
        guard let uiImage = uiImage else { return }
        // ユーザードキュメンントの参照先を定義
        let userRef = Firestore.firestore().collection("users").document(uid)

        // 画像URLを作成
        guard let imageURL = try await ImageUpLoader.uploadImageToStorage(image: uiImage) else { return }
        // Firestoreに保存するデータを定義
        let data: [String: String] = [
            "username": username,
            "bio": bio,
            "imageURL": imageURL
        ]

        do {
            // Firestoreにデータを保存
            try await userRef.updateData(data)
            self.statusMessage = "プロフィールが更新されました"
        } catch {
            self.statusMessage = "更新に失敗しました．もう一度お試しください．"
        }


    }
}
