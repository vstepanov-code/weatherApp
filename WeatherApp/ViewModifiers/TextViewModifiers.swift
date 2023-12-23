//
//  TextViewModfiers.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import SwiftUI

struct HeaderTextStyle1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 90))
            .foregroundColor(.accentColor)
    }
}

struct HeaderTextStyle2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 60))
            .foregroundColor(.accentColor)
    }
}

struct HeaderTextStyle3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 30))
            .foregroundColor(.accentColor)
    }
}

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue Bold", size: 22))
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
    func headerTextStyle1() -> some View {
        self.modifier(HeaderTextStyle1())
    }
    
    func headerTextStyle2() -> some View {
        self.modifier(HeaderTextStyle2())
    }
    
    func headerTextStyle3() -> some View {
        self.modifier(HeaderTextStyle3())
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

