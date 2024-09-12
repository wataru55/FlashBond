//
//  CurrentUserProfileView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/11.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZStack {
            // backgroundimage
            // TODO: 画像をデータベースから取得する
            Image("ironman1")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(.all)

            //MARK: - MenuArea
            MenuView(isOpen: $isMenuOpen)
        }
        .frame(width: UIScreen.main.bounds.width)
        .overlay (alignment: .topTrailing){
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isMenuOpen.toggle()
                }
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundStyle(.gray)
            })
            .padding(15)

        }
        .overlay (alignment: .bottomLeading){
            VStack (alignment: .leading) {
                // TODO: ユーザーネームをデータベースから取得する
                Text("Tony Stark")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                // TODO: 詳細文をデータベースから取得する
                Text("bio")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .offset(x: 30, y: -100)
        }

    }
}

#Preview {
    CurrentUserProfileView()
}
