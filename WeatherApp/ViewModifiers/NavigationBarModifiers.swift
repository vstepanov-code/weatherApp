//
//  NavigationBarModifiers.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import SwiftUI

struct MainNavigationBarTitle: ViewModifier {

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.accent]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func mainNavigationBarStyle() -> some View {
        self.modifier(MainNavigationBarTitle())
    }
}
