//
//  DetailsForecastItemViewModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import Foundation

struct DetailsForecastItemViewModel {
    let date: Date
    let maxTemp: Double
    let minTemp: Double
    let humidity: Int
    let description: String?
    let iconName: String?
    
    var timeTitle: String {
        date.formatted(.dateTime.hour())
    }
    
    var maxTempTitle: String {
        "Max: \(String(Int(maxTemp)))\(GlobalContants.degreesSymbol)"
    }
    
    var minTempTitle: String {
        "Min: \(String(Int(minTemp)))\(GlobalContants.degreesSymbol)"
    }
    
    var humidityTitle: String {
        "\(humidity)%"
    }

    var iconURL: URL? {
        if let iconName {
            URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        } else {
            nil
        }
    }
}