//
//  DataStorageProtocol.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import Foundation

enum DataStorageKey: String {
    case forecast
}

protocol DataStorageProtocol {
    func saveData(_ data: Data, forKey key: DataStorageKey)
    func loadData(forKey key: DataStorageKey) -> Data?
}
