//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 22/12/2023.
//

import XCTest
import Foundation
@testable import WeatherApp

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
