//
//  EditProfileViewModel.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/13.
//

import SwiftUI
import PhotosUI
import Firebase
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
    /// ユーザーが選択した画像を表示するためのプロパティ
    @Published var displayImage: Image?

    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        // item(選択された画像)がnilでないことを確認
        guard let item = item else { return }
        // 画像データを非同期で取得し、バイナリデータとして読み込む
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        // バイナリデータをUIImageに変換
        guard let uiImage = UIImage(data: data) else { return }
        //self.uiImage = uiImage
        self.displayImage = Image(uiImage: uiImage)
    }

}
