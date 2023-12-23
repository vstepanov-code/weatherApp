//
//  WeatherNetworkProvider.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import Foundation

protocol WeatherProviderProtocol {
    func getForecast(for city: String) async throws -> Forecast
}

class WeatherProviderService: WeatherProviderProtocol {
    
    private let weatherNetworkingService: WeatherNetworkingProtocol
    private let networkStatusChecker: NetworkStatusProtocol
    private let storage: DataStorageProtocol
    
    init(weatherNetworkingService: WeatherNetworkingProtocol = WeatherNetworkingService(),
         networkStatusChecker: NetworkStatusProtocol = NetworkStatusChecker(),
         storage: DataStorageProtocol = UserDefaultsStorage()) {
        
        self.weatherNetworkingService = weatherNetworkingService
        self.networkStatusChecker = networkStatusChecker
        self.storage = storage
    }
    
    func getForecast(for city: String) async throws -> Forecast {
        
        if networkStatusChecker.isOffline() {
            if let cachedData = storage.loadData(forKey: .forecast),
               let cachedForecast = try? JSONDecoder().decode(Forecast.self, from: cachedData) {
                return cachedForecast
            }
            throw AppError.noCacheData
        } else {
            do {
                let forecast = try await weatherNetworkingService.getForecast(for: city)
                
                if let data = try? JSONEncoder().encode(forecast) {
                    storage.saveData(data, forKey: .forecast)
                }
                return forecast
            } catch {
                if let cachedData = storage.loadData(forKey: .forecast),
                   let cachedForecast = try? JSONDecoder().decode(Forecast.self, from: cachedData) {
                    return cachedForecast
                }
                throw error
            }
        }
    }
}
