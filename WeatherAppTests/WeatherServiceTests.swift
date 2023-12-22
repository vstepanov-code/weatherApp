//
//  WeatherServiceTests.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 22/12/2023.
//

import XCTest
@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    
    func testGetForecastSuccess() throws {
        do {
            let forecast: Forecast = try getData(fromJSON: "mock_forecast")
            XCTAssertNotNil(forecast)
        } catch {
            XCTFail("Failed with error: \(error)")
        }
    }
}
