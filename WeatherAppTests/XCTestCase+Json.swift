//
//  XCTestCase+Json.swift
//  WeatherAppTests
//
//  Created by Slava Stepanov on 22/12/2023.
//

import XCTest

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
        case decodingError(Error)
    }
    
    func getData<T: Decodable>(fromJSON fileName: String, as decodableType: T.Type = T.self) throws -> T {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing File: \(fileName).json")
            throw TestError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw TestError.decodingError(error)
        }
    }
}
