//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import Foundation

struct Forecast: Decodable {
    let list: [ForecastItem]
    let city: City
}

struct City: Decodable {
    let id: Int
    let name: String
    let country: String
}

struct ForecastItem: Decodable {
    let dt: Int
    let main: Overview
    let weather: [WeatherItem]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}

struct Overview: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

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

struct WeatherItem: Decodable {
    let id: Int
    let main: String?
    let description: String?
    let icon: String?
}
