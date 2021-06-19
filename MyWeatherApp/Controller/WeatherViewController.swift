//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Dinithi De Silva on 2021-06-17.
//

import UIKit

class WeatherViewController: UIViewController, WeatherDataManagerDelegate {
    
    // MARK:- IBOutlets
    @IBOutlet weak var cityTextFeild: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
  // MARK:- Properties
    var weatherDataManager = WeatherDataManager()
    
    // MARK:- App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // assiging delegate
        weatherDataManager.delegate = self
    }
    
    // MARK:- Button actions
    @IBAction func enterButtonClicked(_ sender: Any) {

      if let cityName = cityTextFeild.text, cityName.count > 0{
        let url = weatherDataManager.getURLForCity(city: cityName)
        weatherDataManager.requestWeatherData(urlString: url)
      } else {
        // create the alert
        let alert = UIAlertController(title: "Oops!", message: "Please enter a city", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
      }
    }
    
    // MARK:- WeatherDataManagerDelegate functions
    func weatherDataUpdated(weatherDataModel weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weatherModel.temperature)"
            self.descriptionLabel.text = weatherModel.description
        }
    }
  
    func weatherDataNotReceived(error: String?) {
      DispatchQueue.main.async {
        // create the alert
        let alert = UIAlertController(title: "Oops!", message: "We couldn't find the entered city. Please try another.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
      }
    }
}
