//
//  ContentView.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        if viewModel.userSession == nil {
            LoginView()
        } else {
            MainTabView()
        }

    }
}

#Preview {
    ContentView()
}
