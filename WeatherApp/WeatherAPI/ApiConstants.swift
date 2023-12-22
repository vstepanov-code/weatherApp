//
//  ApiConstants.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import Foundation

struct ApiConstants {
    static let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
    
    static func loadAPIKeys() async throws  {
        let request = NSBundleResourceRequest(tags: ["APIKeys"])
        try await request.beginAccessingResources()
        
        let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
        let data = try Data(contentsOf: url)
        // TODO: Store in keychain and skip NSBundleResourceRequest on next launches
        APIKeys.storage = try JSONDecoder().decode([String: String].self, from: data)
        
        request.endAccessingResources()
    }
    
    enum APIKeys {
        static fileprivate(set) var storage = [String: String]()
        static var weatherAPIKey: String { storage["OpenWeatherAPI"] ?? "" }
    }
}
