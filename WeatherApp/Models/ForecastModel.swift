//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import Foundation

struct Forecast: Codable {
    let list: [ForecastItem]?
    let city: City?
}

struct City: Codable {
    let id: Int
    let name: String?
    let country: String?
}

struct ForecastItem: Codable {
    let dt: Int?
    let main: CurrentState?
    let weather: [WeatherItem]?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}

struct CurrentState: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct WeatherItem: Codable {
    let id: Int
    let main: String?
    let description: String?
    let icon: String?
}
