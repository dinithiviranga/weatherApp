//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Dinithi De Silva on 2021-06-17.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
