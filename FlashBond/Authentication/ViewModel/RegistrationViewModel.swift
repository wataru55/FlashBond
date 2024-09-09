//
//  RegistrationViewModel.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
}
