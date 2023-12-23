//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 22/12/2023.
//

import XCTest
import Foundation
@testable import WeatherApp

class MockNetworkStatusChecker: NetworkStatusProtocol {
    var isOfflineMode = false

    func isOffline() -> Bool {
        return isOfflineMode
    }
}

class MockDataStorage: DataStorageProtocol {
    var data: Data?
    
    func saveData(_ data: Data, forKey key: DataStorageKey) {
        self.data = data
    }
    
    func loadData(forKey key: DataStorageKey) -> Data? {
        return data
    }
}

class MockWeatherService: WeatherNetworkingProtocol {
    var mockForecast: Forecast?
    var error: Error?

    func getForecast(for city: String) async throws -> Forecast {
        if let error = error {
            throw error
        }
        return mockForecast ?? Forecast(list: [], city: City(id: 1, name: "paris", country: "fr"))
    }
}

extension WeatherProviderService {
    
    static func getTestProvider(weatherNetworkingService: WeatherNetworkingProtocol = MockWeatherService(),
                               networkStatusChecker: NetworkStatusProtocol = MockNetworkStatusChecker(),
                               storage: DataStorageProtocol = MockDataStorage()) -> WeatherProviderService {
        return WeatherProviderService(weatherNetworkingService: weatherNetworkingService,
                                      networkStatusChecker: networkStatusChecker,
                                      storage: storage)
    }
}
