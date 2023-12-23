//
//  ButtonViewModifiers.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 16))
            .background(.accent)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
}
