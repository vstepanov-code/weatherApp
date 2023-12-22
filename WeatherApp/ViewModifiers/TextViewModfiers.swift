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
            .font(.custom("Helvetica Neue Bold", size: 44))
            .foregroundColor(.accentColor)
    }
}

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 32))
            .foregroundColor(.accentColor)
    }
}

struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 16))
            .foregroundColor(.accentColor)
    }
}

struct PlainTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 12))
            .foregroundColor(.accentColor)
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

