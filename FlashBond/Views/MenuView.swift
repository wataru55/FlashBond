//
//  MenuView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/11.
//

import SwiftUI

struct MenuView: View {
    /// メニュー開閉
    @Binding var isOpen: Bool
    var body: some View {
        ZStack {
            // menuViewが出てきたときに背景を暗くするため
            Color.black
                .ignoresSafeArea(.all)
                .opacity(isOpen ? 0.7 : 0)
                .onTapGesture {
                    /// isOpenの変化にアニメーションをつける
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isOpen.toggle()
                    }
                }
            //MARK: - MenuContent
            ZStack {
                Color
                    .white.opacity(0.1)
                    .cornerRadius(20.0)

                VStack{
                    // マイページ編集ボタン
                    NavigationLink(destination: {
                        EditProfileView()
                    }, label: {
                        HStack {
                            Image(systemName: "pencil")
                                .font(.title)
                                .foregroundStyle(.white)

                            Text("編集")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)
                        }
                        .frame(width: 200, height: 44)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding(.top, 50)
                    .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 3)

                    // 設定ボタン
                    Button(action: {

                    }, label: {
                        HStack {
                            Image(systemName: "gear")
                                .font(.title)
                                .foregroundStyle(.white)

                            Text("設定")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)


                        }
                        .frame(width: 200, height: 44)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding(.top, 10)
                    .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 3)

                    Spacer()

                    // ログアウトボタン
                    Button(action: {
                        AuthService.shared.signout()
                    }, label: {
                        Text("ログアウト")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(width: 200, height: 44)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding(.vertical, 40)
                    .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 3)
                }// vstack
                .frame(width: UIScreen.main.bounds.width * 2 / 3)
                .frame(maxHeight: .infinity)
            }// zstack
            // 画面幅の1/3だけ左側を開ける
            .padding(.leading, UIScreen.main.bounds.width/3)
            // isOpenで、そのままの位置か、画面幅だけ右にズレるかを決める
            .offset(x: isOpen ? 0 : UIScreen.main.bounds.width)
        }// zstack
    }
}

#Preview {
    MenuView(isOpen: .constant(true))
}
