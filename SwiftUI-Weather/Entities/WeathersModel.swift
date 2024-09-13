//
//  WeathersModel.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 8/8/24.
//

import Foundation

struct WeathersModelResponse: Codable {
    var data: [WeatherModel]
    var city_name: String
    var country_code: String
}

