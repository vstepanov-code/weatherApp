//
//  TextViewModfiers.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import SwiftUI

struct HeaderTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .foregroundColor(.pink)
    }
}

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(.pink)
    }
}

struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(.pink)
    }
}

struct PlainTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .foregroundColor(.pink)
    }
}

extension View {
    func headerTextStyle() -> some View {
        self.modifier(HeaderTextStyle())
    }
    
    func titleTextStyle() -> some View {
        self.modifier(TitleTextStyle())
    }
    
    func subtitleTextStyle() -> some View {
        self.modifier(SubtitleTextStyle())
    }
    
    func plainTextStyle() -> some View {
        self.modifier(PlainTextStyle())
    }
}

