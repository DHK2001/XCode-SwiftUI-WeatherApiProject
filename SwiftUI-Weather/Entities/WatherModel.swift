//
//  WatherModel.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 7/8/24.
//

import Foundation

struct WeatherModel: Codable {
    var temp: Double
    var weather: WeatherDesciprtionModel
    var datetime: String
}

