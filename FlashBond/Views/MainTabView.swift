//
//  MainTabView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/10.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        Button(action: {
            AuthService.shared.signout()
        }, label: {
            Text("ログアウト")
        })
    }
}

#Preview {
    MainTabView()
}
