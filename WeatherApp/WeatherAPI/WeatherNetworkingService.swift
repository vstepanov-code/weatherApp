//
//  WeatherNetworkingService.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import Foundation
import Alamofire

class WeatherNetworkService {
    
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func getForecast(for city: String) async throws -> Forecast {
        let urlString = ApiConstants.baseUrl + "forecast?city=\(city)&units=metric&appid=\(ApiConstants.APIKeys.weatherAPIKey)"
        guard let url = URL(string: urlString) else {
            throw AFError.invalidURL(url: urlString)
        }
        
        return try await fetch(endpoint: url, as: Forecast.self)
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
