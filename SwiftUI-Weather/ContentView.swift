//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Derek H. Galeas on 6/8/24.
//

import SwiftUI

struct WeatherView: View {
    
    @State private var currentWeather: WeatherModel?
    @State private var forecastWeathers: [WeatherModel]?
    @State private var selectCity = ""
    @State private var citiesList = [
        "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ",
        "Philadelphia, PA", "San Antonio, TX", "San Diego, CA", "Dallas, TX", "San Jose, CA",
        "Austin, TX", "Jacksonville, FL", "Fort Worth, TX", "Columbus, OH", "Charlotte, NC",
        "San Francisco, CA", "Indianapolis, IN", "Seattle, WA", "Denver, CO", "Washington, DC",
        "Boston, MA", "El Paso, TX", "Nashville, TN", "Detroit, MI", "Oklahoma City, OK",
        "Portland, OR", "Las Vegas, NV", "Memphis, TN", "Louisville, KY", "Baltimore, MD",
        "Milwaukee, WI", "Albuquerque, NM", "Tucson, AZ", "Fresno, CA", "Sacramento, CA",
        "Kansas City, MO", "Long Beach, CA", "Mesa, AZ", "Atlanta, GA", "Colorado Springs, CO",
        "Virginia Beach, VA", "Raleigh, NC", "Omaha, NE", "Miami, FL", "Oakland, CA",
        "Minneapolis, MN", "Tulsa, OK", "Arlington, TX", "New Orleans, LA", "Wichita, KS",
        "Cleveland, OH", "Tampa, FL", "Bakersfield, CA", "Aurora, CO", "Anaheim, CA",
        "Santa Ana, CA", "Corpus Christi, TX", "Riverside, CA", "Lexington, KY", "Stockton, CA",
        "Henderson, NV", "Saint Paul, MN", "St. Louis, MO", "Cincinnati, OH", "Pittsburgh, PA",
        "Greensboro, NC", "Lincoln, NE", "Anchorage, AK", "Plano, TX", "Orlando, FL",
        "Irvine, CA", "Newark, NJ", "Durham, NC", "Chula Vista, CA", "Toledo, OH",
        "Fort Wayne, IN", "St. Petersburg, FL", "Laredo, TX", "Jersey City, NJ", "Madison, WI",
        "Chandler, AZ", "Buffalo, NY", "Lubbock, TX", "Scottsdale, AZ", "Reno, NV",
        "Glendale, AZ", "Gilbert, AZ", "Winston-Salem, NC", "North Las Vegas, NV", "Norfolk, VA",
        "Chesapeake, VA", "Garland, TX", "Irving, TX", "Hialeah, FL", "Fremont, CA",
        "Boise, ID", "Richmond, VA", "Baton Rouge, LA", "Spokane, WA", "Des Moines, IA"
    ]
    
    var weatherPresenter: WeatherPresenter
    var fromFile = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            if currentWeather != nil && forecastWeathers != nil {
                VStack {
                    CityTextView(
                        cityName:  selectCity
                    ).padding(.bottom, 25)
                    
                    MainWeather(
                        temperature: currentWeather!.temp,
                        imageName: weatherPresenter.getIcons(weatherDescription: currentWeather!.weather.description)
                    ).padding(.bottom, 25)
                    
                    HStack(spacing: 20) {
                        ForEach(Array(forecastWeathers!.enumerated()), id: \.offset) { index, weatherDay in
                            WeatherDayView(
                                dayOfWeek: weatherPresenter.getDay(dateTime: weatherDay.datetime),
                                imageName: weatherPresenter.getIcons(weatherDescription: weatherDay.weather.description),
                                temperature: weatherDay.temp
                            )
                        }
                    }
                    .padding(.bottom, 50)
                    
                    Text("Select a City")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.white)
                    
                    Picker("Select a City", selection: $selectCity) {
                        ForEach(citiesList, id: \.self) { city in
                            Text(city)
                                .tag(city)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(.black)
                    .onChange(of: selectCity) { _ in
                        Task {
                            if fromFile {
                                await initDataWeatherFromFile()
                            } else {
                                await initDataWeather(cityName: selectCity)
                            }
                        }
                    }
                    
                    Spacer()
                }
            } else {
                Text("Network Error")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(.white)
            }
        }.onAppear() {
            Task {
                selectCity = citiesList.first ?? "None"
                
                if fromFile {
                    await initDataWeatherFromFile()
                } else {
                    await initDataWeather(cityName: selectCity)
                }
            }
        }
    }
    
    private func initDataWeather(cityName: String) async {
        await weatherPresenter.getWeatherData(cityName: cityName)
        fetchcurrentWeather()
        getWeatherForeCast()
    }
    
    private func fetchcurrentWeather() {
        currentWeather = weatherPresenter.getCurrentWeather()
    }
    
    private func getWeatherForeCast() {
        forecastWeathers = weatherPresenter.getForeCastWeather()
    }
    
    private func initDataWeatherFromFile() async {
        selectCity = citiesList.first ?? "None"
        weatherPresenter.getWeatherDataFromFile(cityName: selectCity)
        selectCity = weatherPresenter.getCityName()
        fetchcurrentWeather()
        getWeatherForeCast()
    }
    
}

#Preview {
    WeatherView(
        weatherPresenter: WeatherPresenter(
            weatherInteractor: WeatherInteractor()
        )
    )
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
            
            Text(String(format: "%.1f", temperature) + "°")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .blue,
                    Color("lightBlue")
                ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
    }
}

struct MainWeather: View {
    
    var temperature: Double
    var imageName: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(String(format: "%.1f", temperature) + "°")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(.white)
            
        }.padding(.bottom, 40)
    }
}

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundCOlor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 200, height: 50)
            .background(backgroundCOlor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
