//
//  CreatePasswordView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss

    let _width = UIScreen.main.bounds.width

    var body: some View {
        VStack (spacing: 10) {
            Text("パスワードの登録")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("６文字以上でパスワードを登録してください")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.bottom)

            TextField("パスワード", text: $viewModel.password)
                .textInputAutocapitalization(.none)
                .modifier(TextFieldModifier())

            NavigationLink {
                CompleteSignUpView()
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
} // CreatePasswordView

#Preview {
    CreatePasswordView()
}
