//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var currentTemperatureTitle: String?
    @Published var currentCityTitle: String?
    @Published var dailyForecastList: [ForecastDayItem] = []
    @Published var error: Error?

    var forecast: Forecast?
    private let weatherProvider: WeatherProviderProtocol
    private var refreshDataTask: Task<Void, Never>?

    init(weatherProvider: WeatherProviderProtocol = WeatherProviderService()) {
        self.weatherProvider = weatherProvider
    }
    
    @MainActor
    func refreshData() async {
        isLoading = true
        refreshDataTask?.cancel()
        
        refreshDataTask = Task {
            defer { isLoading = false }
            do {
                let forecast = try await weatherProvider.getForecast(for: "Paris")
                processForecastData(forecast)
            } catch {
                self.error = error
            }
        }
        
        await refreshDataTask?.value
    }
    
    private func processForecastData(_ forecast: Forecast) {
        self.forecast = forecast
        updateCurrentWeather(from: forecast)
        updateDailyForecast(from: forecast)
    }
    
    private func updateCurrentWeather(from forecast: Forecast) {
        guard let currentData = forecast.list.first else {
            return
        }
        
        currentTemperatureTitle = "\(Int(currentData.main.temp))°C"
        currentCityTitle = forecast.city.name
    }
    
    private func updateDailyForecast(from forecast: Forecast) {
        let groupedByDay = Dictionary(grouping: forecast.list) {
            let date = Date(timeIntervalSince1970: TimeInterval($0.dt))
            let startOfDay = Calendar.current.startOfDay(for: date)
            return startOfDay
        }
        
        dailyForecastList = groupedByDay.keys.sorted().compactMap { date in
            processDailyForecast(for: date, with: groupedByDay[date])
        }
    }
    
    private func processDailyForecast(for date: Date, with values: [ForecastItem]?) -> ForecastDayItem? {
        guard let values = values,
              let maxTempForecast = values.max(by: { $0.main.tempMax < $1.main.tempMax }),
              let minTempForecast = values.min(by: { $0.main.tempMin < $1.main.tempMin }) else {
            return nil
        }
        
        
        return ForecastDayItem(date: date,
                               maxTemp: maxTempForecast.main.tempMax,
                               minTemp: minTempForecast.main.tempMin,
                               humidity: maxTempForecast.main.humidity,
                               description: minTempForecast.weather.first?.main,
                               iconName: maxTempForecast.weather.first?.icon)
    }
}
