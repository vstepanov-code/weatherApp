//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject {
    
    @Published var detailedForecastList: [Date:[DetailsForecastItemViewModel]] = [:]
    
    init(forecast: Forecast) {
        updateDetailedForecast(for: forecast)
    }
    
    private func updateDetailedForecast(for forecast: Forecast) {
        let groupedByDay = Dictionary(grouping: forecast.list) {
            let date = Date(timeIntervalSince1970: TimeInterval($0.dt))
            let startOfDay = Calendar.current.startOfDay(for: date)
            return startOfDay
        }
        
        detailedForecastList = groupedByDay.mapValues { items in
            processDailyForecast(for: items)
        }
    }
    
    private func processDailyForecast(for items: [ForecastItem]) -> [DetailsForecastItemViewModel] {
        return items.map { item in
            DetailsForecastItemViewModel(date: Date(timeIntervalSince1970: TimeInterval(item.dt)),
                                         maxTemp: item.main.tempMax,
                                         minTemp: item.main.tempMin,
                                         humidity: item.main.humidity,
                                         description: item.weather.first?.main,
                                         iconName: item.weather.first?.icon)
        }
    }
}
