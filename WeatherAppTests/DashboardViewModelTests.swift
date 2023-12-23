//
//  DashboardViewModelTests.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 22/12/2023.
//

import XCTest
@testable import WeatherApp

class DashboardViewModelTests: XCTestCase {

    func testLoadForecastSuccess() async {
        
        let mockNetworkingService = MockWeatherService()
        mockNetworkingService.mockForecast = try? getData(fromJSON: "mock_forecast")
        let provider = WeatherProviderService.getTestProvider(weatherNetworkingService: mockNetworkingService)
        
        let viewModel = DashboardViewModel(weatherProvider: provider)

        await viewModel.refreshData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.currentTemperatureTitle)
        XCTAssertNotNil(viewModel.currentCityTitle)
        XCTAssertFalse(viewModel.dailyForecastList.isEmpty)
    }

    func testLoadForecastWithEmptyData() async {
        let mockNetworkingService = MockWeatherService()
        mockNetworkingService.mockForecast = Forecast(list: [], city: City(id: 1, name: "Paris", country: ""))

        let provider = WeatherProviderService.getTestProvider(weatherNetworkingService: mockNetworkingService)

        let viewModel = DashboardViewModel(weatherProvider: provider)

        await viewModel.refreshData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.currentTemperatureTitle)
        XCTAssertNil(viewModel.currentCityTitle)
        XCTAssertTrue(viewModel.dailyForecastList.isEmpty)
    }

    func testLoadForecastFailure() async {
        let mockNetworkingService = MockWeatherService()
        mockNetworkingService.error = NSError(domain: "", code: 0, userInfo: nil)

        let provider = WeatherProviderService.getTestProvider(weatherNetworkingService: mockNetworkingService)
        let viewModel = DashboardViewModel(weatherProvider: provider)

        await viewModel.refreshData()
        
        XCTAssertNotNil(viewModel.error)
    }
}
