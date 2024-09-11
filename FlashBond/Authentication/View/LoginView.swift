//
//  LoginView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    @State private var errorMessage: String? = nil

    let _width = UIScreen.main.bounds.width

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                // アプリのロゴ
                //TODO: ロゴ画像を追加する
                HStack (spacing: 0) {
                    Text("Flash")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(colors: [Color.black, Color.yellow], startPoint: .leading, endPoint: .trailing))

                    Image(systemName: "bolt.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)

                    Text("Bond")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(colors: [Color.yellow, Color.black], startPoint: .leading, endPoint: .trailing))

                }
                .frame(width: _width)
                .padding(.bottom, 50)
                .overlay (alignment: .bottom) {
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                            .animation(.easeInOut, value: errorMessage) // フェードイン/アウトを適用
                    }
                }

                // テキストフィールド
                VStack (spacing: 15) {
                    TextField("メールアドレス", text: $viewModel.email)
                        .modifier(TextFieldModifier())

                    SecureField("パスワード", text: $viewModel.password)
                        .modifier(TextFieldModifier())

                }

                Button(action: {
                    print("show forgot password")
                }, label: {
                    Text("パスワードを忘れた？")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        .padding(.top)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.vertical, 5)

                Button(action: {
                    Task {
                        do {
                            try await viewModel.login()
                        } catch {
                            errorMessage = "ログインに失敗しました もう一度お試しください"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    errorMessage = nil
                                }
                            }
                        }
                    }

                }, label: {
                    Text("ログイン")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: _width - 30, height: 40)
                        .background(LinearGradient(colors: [Color.indigo, Color.blue], startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        .padding(.top, 20)
                })
                .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 2)

                Spacer()

                Divider()

                NavigationLink {
                    AddEmailView()
                } label: {
                    Text("アカウントの新規作成")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                .padding(.vertical)
            } // VStack
        } // NavigationStack
    } // body
} // LoginView

#Preview {
    LoginView()
}
