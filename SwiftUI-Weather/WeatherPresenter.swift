//
//  WeatherPresenter.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 8/8/24.
//

import Foundation

protocol WeatherPresentable:AnyObject{
    func getForeCastWeather() -> [WeatherModel]?
    func getDay(dateTime: String) -> String
    func getCurrentWeather() -> WeatherModel?
    func getWeatherData(cityName: String) async
    func getWeatherDataFromFile(cityName: String)
    func getCityName() -> String
}

class WeatherPresenter: WeatherPresentable {
    
    private var weather: WeathersModelResponse?
    private let weatherInteractor: WeatherInteractor
    private var currentDateTime: String?
    
    init(weatherInteractor: WeatherInteractor) {
        self.weatherInteractor = weatherInteractor
    }
    
    func getWeatherData(cityName: String) async {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
        let currentDate = Date()
        currentDateTime = inputFormatter.string(from: currentDate)
        
        let weathersArray = await weatherInteractor.getCurrentWeather(cityName: cityName)
        weather = weathersArray ?? nil
    }
    
    func getWeatherDataFromFile(cityName: String) {
        
        currentDateTime = "2024-08-12"
        
        let weathersArray = weatherInteractor.getWeatherFromFile()
        weather = weathersArray ?? nil
    }
    
    func getForeCastWeather() -> [WeatherModel]? {
        if weather != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let todayDateString = currentDateTime
            var filteredWeathers = weather!.data
            
            filteredWeathers.removeAll { $0.datetime == todayDateString }
            
            return Array(filteredWeathers.prefix(5))
        }
        
        return nil
    }
    
    func getDay(dateTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateTime) {
            let dayAbbreviation = outputFormatter.string(from: date).uppercased()
            return dayAbbreviation
        }
        
        return ""
    }
    
    func getCurrentWeather() -> WeatherModel? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let todayDateString = currentDateTime ?? "2024-08-12"
        
        if weather != nil {
            let currentWeather = weather?.data.first(where: {$0.datetime == todayDateString})
            return currentWeather
        }
        
        return nil
    }
    
    func getCityName() -> String {
        return weather?.city_name ?? ""
    }
    
    func getIcons(weatherDescription: String) -> String {
        
        if weatherDescription == "Thunderstorm with light rain" {
                return "cloud.bolt.rain.fill"
        }
        
        if weatherDescription == "Thunderstorm with rain" {
            return "cloud.bolt.rain.fill"
        }
        
        if weatherDescription == "Thunderstorm with heavy rain" {
            return "cloud.bolt.rain.fill"
        }
        
        if weatherDescription == "Thunderstorm with light drizzle" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Thunderstorm with drizzle" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Thunderstorm with heavy drizzle" {
            return "cloud.drizzle.fill"
        } 
        
        if weatherDescription == "Thunderstorm with hail" {
                return "cloud.hail.fill"
        } 
        
        if weatherDescription == "Light drizzle" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Drizzle" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Heavy drizzle" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Light rain" {
            return "cloud.drizzle.fill"
        }
        
        if weatherDescription == "Moderate rain" {
            return "cloud.rain.fill"
        }
        
        if weatherDescription == "Heavy rain" {
            return "cloud.heavyrain.fill"
        }
        
        if weatherDescription == "Freezing rain" {
            return "cloud.sleet.fill"
        } 
        
        if weatherDescription == "Light shower rain" {
            return "cloud.rain.fill"
        }
        
        if weatherDescription == "Shower rain" {
            return "cloud.rain.fill"
        }
        
        if weatherDescription == "Heavy shower rain" {
            return "cloud.heavyrain.fill"
        }
        
        if weatherDescription == "Light snow" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Snow" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Heavy snow" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Mix snow/rain" {
            return "cloud.sleet.fill"
        }
        
        if weatherDescription == "Sleet" {
            return "cloud.sleet.fill"
        }
        
        if weatherDescription == "Heavy sleet" {
            return "cloud.sleet.fill"
        }
        
        if weatherDescription == "Snow shower" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Heavy snow shower" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Flurries" {
            return "cloud.snow.fill"
        }
        
        if weatherDescription == "Mist" {
            return "cloud.fog.fill"
        }
        
        if weatherDescription == "Smoke" {
            return "smoke.fill"
        }
        
        if weatherDescription == "Haze" {
            return "sun.haze.fill"
        }
        
        if weatherDescription == "Sand/dust" {
            return "cloud.fog.fill"
        }
        
        if weatherDescription == "Fog" {
            return "cloud.fog.fill"
        }
        
        if weatherDescription == "Freezing fog" {
            return "cloud.fog.fill"
        }
        
        if weatherDescription == "Clear sky" {
            return "sun.max.fill"
        }
        
        if weatherDescription == "Few clouds" {
            return "cloud.sun.fill"
        }
        
        if weatherDescription == "Scattered clouds" {
            return "cloud.fill"
        }
        
        if weatherDescription == "Broken clouds" {
            return "cloud.fill"
        }
        
        if weatherDescription == "Overcast clouds" {
            return "smoke.fill"
        }
        
        if weatherDescription == "Unknown precipitation" {
            return "questionmark"
        } 
        
        return "questionmark"
    }
    
}
