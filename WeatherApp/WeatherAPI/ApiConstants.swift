//
//  ApiConstants.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case missingAPIKey
    case noCacheData
}

protocol ApiConstantsProtocol {
    var baseUrl: String { get }
    var weatherAPIKey: String? { get }
    func loadAPIKeys() async throws
}

class ApiConstants: ApiConstantsProtocol {
        
    static let shared = ApiConstants()
    
    private var storage = [String: String]()
    
    var baseUrl: String { "https://api.openweathermap.org/data/2.5/" }
    var weatherAPIKey: String? { storage["OpenWeatherAPI"] }
    
    private init() {}

    func loadAPIKeys() async throws  {
        let request = NSBundleResourceRequest(tags: ["APIKeys"])
        try await request.beginAccessingResources()
        
        let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
        let data = try Data(contentsOf: url)
        // TODO: Store in keychain and skip NSBundleResourceRequest on next launches
        storage = try JSONDecoder().decode([String: String].self, from: data)
        request.endAccessingResources()
    }
}
