//
//  LoginViewModel.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
}
