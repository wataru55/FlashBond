//
//  HomeView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Button(action: {
            AuthService.shared.signout()
        }, label: {
            Text("ログアウト")
        })
    }
}

#Preview {
    HomeView()
}
