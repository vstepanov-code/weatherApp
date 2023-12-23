//
//  ForecastDayItem.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

struct ForecastDayItem {
    let date: Date
    let maxTemp: Double
    let minTemp: Double
    let humidity: Int
    let description: String?
    let iconName: String?
    
    var dayTitle: String {
        date.formatted(.dateTime.day().month(.abbreviated).weekday(.abbreviated))
    }
    
    var maxTempTitle: String {
        let formatString = NSLocalizedString("max_temperature", comment: "")
        return String(format: formatString, Int(maxTemp), GlobalContants.degreesSymbol.rawValue)
    }
    
    var minTempTitle: String {
        let formatString = NSLocalizedString("min_temperature", comment: "")
        return String(format: formatString, Int(minTemp), GlobalContants.degreesSymbol.rawValue)
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
