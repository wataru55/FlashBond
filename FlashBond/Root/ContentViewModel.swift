//
//  ContentViewModel.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/10.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupUserSessionSubscriber()
        setupCurrentUserSubscriber()
    }

    // userSessionに関する購読設定
    private func setupUserSessionSubscriber() {
        service.$userSession
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
    }

    // currentUserに関する購読設定
    private func setupCurrentUserSubscriber() {
        service.$currentUser
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }

    func forceSignout() {
        // service.signout()
        print("ユーザデータが見つかりませんでした")
    }
}
