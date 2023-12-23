//
//  WeatherNetworkingService.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import Foundation
import Alamofire

protocol WeatherNetworkingProtocol {
    func getForecast(for city: String) async throws -> Forecast
}

class WeatherNetworkingService: WeatherNetworkingProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let apiConstants: ApiConstantsProtocol
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder(), apiConstants: ApiConstantsProtocol = ApiConstants.shared) {
        self.session = session
        self.decoder = decoder
        self.apiConstants = apiConstants
    }
    
    func getForecast(for city: String) async throws -> Forecast {
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric")]
        
        guard let url = try? await createURL(for: "forecast", queryItems: queryItems) else {
            throw AppError.invalidURL
        }
        
        return try await fetch(endpoint: url, as: Forecast.self)
    }
    
    private func createURL(for path: String, queryItems: [URLQueryItem]) async throws -> URL {
        if apiConstants.weatherAPIKey == nil {
            try await apiConstants.loadAPIKeys()
        }
        
        guard let weatherAPIKey = apiConstants.weatherAPIKey else {
            throw AppError.missingAPIKey
        }
        
        guard var url = URL(string: apiConstants.baseUrl) else {
            throw AppError.invalidURL
        }
        
        url.append(path: path)
        url.append(queryItems: queryItems + [URLQueryItem(name: "appid", value: weatherAPIKey)])
        return url
    }
        
    private func fetch<T: Decodable>(endpoint: URL, as type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endpoint, method: .get).responseDecodable(of: T.self, decoder: decoder) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
