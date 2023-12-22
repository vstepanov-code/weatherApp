//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation
import SwiftUI

struct ForecastDayItem {
    let dayTitle: String
    let maxTemp: Double
    let minTemp: Double
    let humidity: Int
    let description: String?
    let iconName: String?
    
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

@MainActor
class DashboardViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var currentTemperatureTitle: String?
    @Published var currentCityTitle: String?
    @Published var dailyForecastList: [ForecastDayItem] = []
    
    private let weatherService: WeatherNetworkingProtocol
    
    init(weatherService: WeatherNetworkingProtocol = WeatherNetworkingService()) {
        self.weatherService = weatherService
    }
    
    func loadForecast() {
        isLoading = true
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                let forecast = try await weatherService.getForecast(for: "Paris")
                update(for: forecast)
            } catch {
            }
        }
    }
    
    private func update(for forecast: Forecast) {
        guard let currentData = forecast.list.first else {
            return
        }
        
        self.currentTemperatureTitle = "\(Int(currentData.main.temp))°C"
        self.currentCityTitle = forecast.city.name
        
        let groupedByDay = Dictionary(grouping: forecast.list) { (element) -> Date in
            let date = Date(timeIntervalSince1970: TimeInterval(element.dt ))
            let startOfDay = Calendar.current.startOfDay(for: date)
            return startOfDay
        }
        
        let sortedKeys = groupedByDay.keys.sorted()
        self.dailyForecastList = sortedKeys.compactMap { date -> ForecastDayItem? in
            guard let values = groupedByDay[date],
                  let maxTempForecast = values.max(by: { $0.main.tempMax < $1.main.tempMax }),
                  let minTempForecast = values.min(by: { $0.main.tempMin < $1.main.tempMin }) else {
                return nil
            }
            
            let dayTitle = date.formatted(.dateTime.day().month(.abbreviated).weekday(.abbreviated))
            
            return ForecastDayItem(dayTitle: dayTitle,
                                   maxTemp: maxTempForecast.main.tempMax,
                                   minTemp: minTempForecast.main.tempMin, 
                                   humidity: maxTempForecast.main.humidity,
                                   description: minTempForecast.weather.first?.main,
                                   iconName: maxTempForecast.weather.first?.icon)
        }
    }
}
