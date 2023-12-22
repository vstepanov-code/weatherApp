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
        let mockWeatherService = MockWeatherService()
        mockWeatherService.mockForecast = try? getData(fromJSON: "mock_forecast")
        let viewModel = DashboardViewModel(weatherService: mockWeatherService)

        await viewModel.refreshData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.currentTemperatureTitle)
        XCTAssertNotNil(viewModel.currentCityTitle)
        XCTAssertFalse(viewModel.dailyForecastList.isEmpty)
    }

    func testLoadForecastWithEmptyData() async {
        let mockWeatherService = MockWeatherService()
        let viewModel = DashboardViewModel(weatherService: mockWeatherService)

        // Configure mockWeatherService to return an empty forecast
        mockWeatherService.mockForecast = Forecast(list: [], city: City(id: 1, name: "Paris", country: ""))

        await viewModel.refreshData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.currentTemperatureTitle)
        XCTAssertNil(viewModel.currentCityTitle)
        XCTAssertTrue(viewModel.dailyForecastList.isEmpty)
    }

    func testLoadForecastFailure() async {
        let mockWeatherService = MockWeatherService()
        let viewModel = DashboardViewModel(weatherService: mockWeatherService)

        mockWeatherService.error = NSError(domain: "", code: 0, userInfo: nil)

        await viewModel.refreshData()
    }
}
