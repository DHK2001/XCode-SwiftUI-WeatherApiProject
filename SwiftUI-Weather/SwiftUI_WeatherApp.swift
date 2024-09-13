//
//  SwiftUI_WeatherApp.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 6/8/24.
//

import SwiftUI

@main
struct SwiftUI_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(
                weatherPresenter: WeatherPresenter(
                    weatherInteractor: WeatherInteractor()
                )
            )
        }
    }
}
