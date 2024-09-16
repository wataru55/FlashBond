//
//  CurrentUserProfileView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/11.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @State private var isMenuOpen = false
    let currentUser: User

    var body: some View {
        NavigationStack {
            ZStack {
                // backgroundimage
                Group {
                    if let url = currentUser.imageURL, !url.isEmpty {
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width)
                                .frame(maxHeight: .infinity)
                                .ignoresSafeArea(.all)
                        } placeholder: {
                            // ローディング中やエラー時に表示されるプレースホルダー
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .frame(width: UIScreen.main.bounds.width)
                            .frame(maxHeight: .infinity)
                            .ignoresSafeArea(.all)
                            .background(
                                Color.gray.opacity(0.3)
                            )
                    }
                }

                //MARK: - MenuArea
                MenuView(isOpen: $isMenuOpen, currentUser: currentUser)
            }// ZStack
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
                    Text(currentUser.username)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    if let bio = currentUser.bio {
                        Text(bio)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .offset(x: 30, y: -100)
            }
        }// NavigationStack
    }
}

#Preview {
    CurrentUserProfileView(currentUser: User.MOCK_USERS[0])
}
