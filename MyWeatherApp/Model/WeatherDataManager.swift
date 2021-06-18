//
//  WeatherData.swiftßßß
//  MyWeatherApp
//
//  Created by Dinithi De Silva on 2021-06-17.
//

import Foundation

protocol WeatherDataManagerDelegate {
    func weatherDataUpdated(weatherDataModel: WeatherModel)
}

struct WeatherDataManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c887fd0aca8ea017498075cc75134906"
    var delegate: WeatherDataManagerDelegate?
    
    func getURLForCity(city: String) -> String {
        return "\(weatherUrl)&q=\(city)"
    }
    
    func requestWeatherData(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
        
            //Create a Session
            let urlSession = URLSession(configuration: .default)
            
            //Create a Task
            let task = urlSession.dataTask(with: url, completionHandler:  onComplete(data: urlResponse: error:))
            
            task.resume()
        }
    }
    
    func onComplete(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if (error != nil) {
            print(error!)
            return
        }
        
        if let responseData = data {
            if let weatherModel = parseJson(data: responseData) {
                delegate?.weatherDataUpdated(weatherDataModel: weatherModel)
            }
        }
    }
    
    func parseJson(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let weatherModel = WeatherModel(name: decodedData.name, temperature: decodedData.main.temp, description: decodedData.weather[0].description)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
    }
}
