//
//  WeatherInteractor.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 8/8/24.
//

import Foundation

protocol WeatherInteractorProtocol: AnyObject {
    func getCurrentWeather(cityName: String) async -> WeathersModelResponse?
}

class WeatherInteractor: WeatherInteractorProtocol {
    private let apiKey = "a42308e8819e4e2ba591ce4d5b413bcd"
    private let api = "https://api.weatherbit.io"
    
    func getCurrentWeather(cityName: String) async -> WeathersModelResponse? {
        let urlString = "\(api)/v2.0/forecast/daily?city=\(cityName)&key=\(apiKey)&include=minutely"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(WeathersModelResponse.self, from: data)
            return response
        } catch {
            print("Failed to fetch weather data: \(error)")
            return nil
        }
    }
    
    func getWeatherFromFile() -> WeathersModelResponse? {
        guard let path = Bundle.main.path(forResource: "weatherTest", ofType: "json") else {
            print("JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let response = try decoder.decode(WeathersModelResponse.self, from: data)
            return response
        } catch {
            print("Failed to load and decode JSON: \(error)")
            return nil
        }
    }
    
}
