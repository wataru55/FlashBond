//
//  CreateUserNameView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct CreateUserNameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss

    let _width = UIScreen.main.bounds.width

    var body: some View {
        VStack (spacing: 10) {
            Text("ユーザーネームの登録")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("""
                ユーザーネームを登録してください
                いつでも変更可能です
                """)
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.bottom)

            TextField("ユーザーネーム", text: $viewModel.username)
                .textInputAutocapitalization(.none)
                .modifier(TextFieldModifier())

            NavigationLink {
                CreatePasswordView()
                    .environmentObject(viewModel)
            } label: {
                Text("次へ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: _width - 30, height: 40)
                    .background(LinearGradient(colors: [Color.indigo, Color.blue], startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    .padding(.top)
            }
            .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 2)

            Spacer()
        } // VStack
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    } // body
} // CreateUserNameView

#Preview {
    CreateUserNameView()
}
