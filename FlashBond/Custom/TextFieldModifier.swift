//
//  TextFieldModifier.swift
//  FlashBond
//
//  Created by  髙橋和 on 2024/09/09.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.none)
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
            .padding(.horizontal)
    }
}
