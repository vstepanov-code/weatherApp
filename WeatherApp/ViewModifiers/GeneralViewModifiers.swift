//
//  GeneralViewModifiers.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(16)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
}
