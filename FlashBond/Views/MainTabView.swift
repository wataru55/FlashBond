//
//  MainTabView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/10.
//

import SwiftUI

struct MainTabView: View {
    init() {
        let appearance: UITabBarAppearance = UITabBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            RoomListView()
                .tabItem {
                    Image(systemName: "ellipsis.bubble")
                    Text("Rooms")
                }
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("MyProfile")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView()
}
