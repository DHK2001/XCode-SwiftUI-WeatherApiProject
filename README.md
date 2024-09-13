# Weather App with SwiftUI and VIPER Architecture

This project is a weather application built using Xcode with SwiftUI for the user interface. It allows users to view the current weather and a 5-day forecast for a selected city by using a free weather API. The app is designed as a practice project to implement SwiftUI, API integration, and the VIPER architecture.

## Features

- **Current Weather**: Displays the current weather conditions for the selected city.
- **5-Day Forecast**: Shows weather predictions for the upcoming five days.
- **City Selection**: Users can select a city to view its weather information.
- **SwiftUI Interface**: The app uses SwiftUI to create a responsive and modern user interface.

## VIPER Architecture

The project follows the VIPER architecture, a design pattern that separates concerns to ensure the app is maintainable, testable, and scalable. This project demonstrates the practical implementation of this architecture in a real-world scenario.

## API Usage and Limitations

The weather data is retrieved from a free API, which has a daily request limit. When this limit is exceeded, the app can switch to local mode using a JSON file (`WeatherTest.json`) stored within the project.

### Local Data Mode

When the daily request limit is reached, the app can switch to local mode, loading weather data from the `WeatherTest.json` file. In this mode, the city selection feature is disabled because the data is static and not dynamically fetched from the API.

### How to Enable Local Mode

To enable the app to run with local data:

1. Open `ContentView.swift`.
2. Navigate to line 39.
3. Set the variable `fromFile` to `true`.

This will switch the data source from the API to the local `WeatherTest.json` file. Please note that this requires manual intervention and will disable the ability to select different cities.

## Purpose of the Project

This project was created with the following goals:

- **Practice SwiftUI UI design**: Understand how to create interfaces using SwiftUI.
- **API integration**: Implement integration of an external API to fetch and display weather data.
- **Simple VIPER architecture implementation**: Gain hands-on experience with the VIPER architecture in a practical setting.
