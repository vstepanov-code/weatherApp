//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var currentTemperatureTitle: String?
    @Published var currentCityTitle: String?
    @Published var dailyForecastList: [ForecastDayItem] = []
    
    private let weatherService: WeatherNetworkingProtocol
    
    init(weatherService: WeatherNetworkingProtocol = WeatherNetworkingService()) {
        self.weatherService = weatherService
    }
    
}
