//
//  GlobalContants.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

enum Degree: String, CustomStringConvertible {
    case celsius = "°C"
    case fahrenheit = "ºF"
    
    var description: String {
        return self.rawValue
    }
}

class GlobalContants {
    private init() {}
    static var degreesSymbol: Degree = .celsius
}
