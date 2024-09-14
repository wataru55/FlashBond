//
//  EditProfileView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/12.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss

    @State private var isPickerPresented = false
    @State private var isEditing = false
    @State private var statusMessage: String? = nil

    let _width =  UIScreen.main.bounds.width

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false){
                // 画像
                // TODO: 保存した画像を表示する
                if let displayImage = viewModel.displayImage {
                    displayImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: _width - 10, height: UIScreen.main.bounds.height / 2)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()
                        .onTapGesture {
                            if isEditing {
                                isPickerPresented.toggle()
                            }
                        }
                } else {
                    Button {
                        isPickerPresented.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 12).stroke(style: .init(lineWidth: 2, dash: [2, 4]))
                            .foregroundStyle(.black)
                            .padding(.horizontal, 5)
                            .frame(width: _width, height: UIScreen.main.bounds.height / 2)
                            .overlay {
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.title)
                                        .foregroundStyle(.black)
                                        .padding(.bottom, 10)

                                    Text("画像を選択")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                            }
                    }
                    .padding(.bottom, 10)
                }

                Divider()
                    .padding(.bottom, 10)

                // ユーザーネーム
                // TODO: ユーザーネームをデータベースから取得する
                Section {
                    TextField("ユーザーネーム", text: $viewModel.username)
                        .frame(width: _width)
                        .modifier(TextFieldModifier())
                        .allowsHitTesting(isEditing)
                        .padding(.leading, 10)

                } header: {
                    Text("ユーザーネーム")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(width: _width, alignment: .leading)
                        .padding(.leading, 10)
                }

                // ユーザーについての詳細文
                // TODO: 詳細文をデータベースから取得する
                Section {
                    TextField("詳細文", text: $viewModel.bio, axis: .vertical)
                        .frame(width: _width, height: 150)
                        .modifier(TextFieldModifier())
                        .lineLimit(0...10)
                        .allowsHitTesting(isEditing)
                        .padding(.leading, 10)

                } header: {
                    Text("詳細文")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(width: _width, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                }
            }// scrollView
            .photosPicker(isPresented: $isPickerPresented, selection: $viewModel.selectedImage, matching: .images)
        }// VStack
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        isEditing.toggle()
                    } label: {
                        Text("編集")
                            .font(.subheadline)
                            .foregroundStyle(isEditing ? .gray : .black)
                    }

                    Button {
                        Task {
                            do {
                                try await viewModel.saveProfileToFirestore()
                                viewModel.statusMessage = "プロフィールが更新されました"
                                showMessageTemporarily()
                            } catch ProfileError.emptyUsername {
                                viewModel.statusMessage = "ユーザーネームを入力してください"
                                showMessageTemporarily()
                            } catch {
                                viewModel.statusMessage = "更新に失敗しました．もう一度お試しください．"
                                showMessageTemporarily()
                            }
                        }
                    } label: {
                        Text("保存")
                            .font(.subheadline)
                            .foregroundStyle(isEditing ? .black : .gray)
                            .disabled(isEditing ? false : true)
                    }
                }
            }
        }
        .overlay {
            if let statusMessage = viewModel.statusMessage {
                VStack {
                    Text(statusMessage)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                }
            }
        }
    }// body
    // 2秒後にメッセージを消す関数
        private func showMessageTemporarily() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    viewModel.statusMessage = nil // 2秒後にメッセージを消す
                }
            }
        }
}// EditProfileView

#Preview {
    EditProfileView()
}
