//
//  WeatherProviderServiceTests.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 23/12/2023.
//

import XCTest
@testable import WeatherApp

class WeatherProviderServiceTests: XCTestCase {
    
    func testGetForecastOnlineSuccessful() async throws {
        let mockNetworkingService = MockWeatherService()
        mockNetworkingService.mockForecast = try? getData(fromJSON: "mock_forecast")
        let provider = WeatherProviderService.getTestProvider(weatherNetworkingService: mockNetworkingService)

        let forecast = try await provider.getForecast(for: "Paris")
        XCTAssertEqual(forecast.city.name, "Paris")
    }

    func testGetForecastOfflineWithCache() async throws {
        let mockNetworkStatus = MockNetworkStatusChecker()
        mockNetworkStatus.isOfflineMode = true
        let mockStorage = MockDataStorage()

        let cachedForecast: Forecast = Forecast(list: [], city: City(id: 0, name: "Paris", country: "fr"))
        let cachedData = try JSONEncoder().encode(cachedForecast)
        mockStorage.saveData(cachedData, forKey: .forecast)

        let provider = WeatherProviderService.getTestProvider(networkStatusChecker: mockNetworkStatus, storage: mockStorage)

        let forecast = try await provider.getForecast(for: "Paris")
        XCTAssertEqual(forecast.city.name, "Paris")
    }

    func testGetForecastOfflineNoCache() async throws {
        let mockNetworkStatus = MockNetworkStatusChecker()
        mockNetworkStatus.isOfflineMode = true
        
        let provider = WeatherProviderService.getTestProvider(networkStatusChecker: mockNetworkStatus)

        do {
            let _ = try await provider.getForecast(for: "Paris")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssert(error is AppError)
        }
    }

}
