//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Dinithi De Silva on 2021-06-17.
//

import UIKit

class WeatherViewController: UIViewController, WeatherDataManagerDelegate {
    
    @IBOutlet weak var cityTextFeild: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var weatherDataManager = WeatherDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDataManager.delegate = self
    }
    
    
    @IBAction func enterButtonClicked(_ sender: Any) {
        
        let url = weatherDataManager.getURLForCity(city: cityTextFeild.text ?? "London")
        
        weatherDataManager.requestWeatherData(urlString: url)
    }
    
    func weatherDataUpdated(weatherDataModel weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weatherModel.temperature)"
            self.descriptionLabel.text = weatherModel.description
        }
    }
    
}
