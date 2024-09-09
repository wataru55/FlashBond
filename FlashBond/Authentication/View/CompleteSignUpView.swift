//
//  CompleteSignUpView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss

    let _width = UIScreen.main.bounds.width

    var body: some View {
        VStack (spacing: 10) {
            Text("\(viewModel.username)")
                .multilineTextAlignment(.center)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("FlashBondへようこそ！")
                .multilineTextAlignment(.center)
                .font(.title2)
                .fontWeight(.bold)

            Text("下のボタンを押して，FlashBondを始めよう")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.bottom)

            Button(action: {
                print(viewModel.$email, viewModel.$password, viewModel.$username)
            }, label: {
                Text("登録を完了")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: _width - 30, height: 40)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .padding(.top)
            })
            .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 2)
        } // VStack
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    } // body
} // CompleteSignUpView

#Preview {
    CompleteSignUpView()
}
