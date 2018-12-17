
import UIKit

struct Times: Decodable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func pressHereButtonTapped(_ sender: Any) {
        let randomNumber = Int(arc4random_uniform(4))
        parse(number: randomNumber)
    }
    
    func parse(number: Int){
        let jsonUrlString = "https://api.sunrise-sunset.org/json?lat=42.3642&lng=42.3642&date=today/\(number)/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let times = try JSONDecoder().decode(Times.self, from: data)
                let sunrise = times.sunrise
                let sunset = times.sunset
                let solar_noon = times.solar_noon
                let day_length = times.day_length
                print(sunrise, sunset, solar_noon, day_length)
                self.setSolarProperties(timesSunrise: sunrise, timesSunset: sunset, timesSolarNoon: solar_noon, timesDayLength: day_length)
//                self.times(timesSunrise: sunrise, timesSunset: sunset, timesSolarNoon: solar_noon, timesDayLength: day_length)
            } catch let jsonErr {
                print("Error Serializing Data:", jsonErr)
            }
        }.resume()
    }
    
    func setSolarProperties(timesSunrise: String, timesSunset: String, timesSolarNoon: String, timesDayLength: String) {
        DispatchQueue.main.async {
            self .sunriseLabel.text = "Sunrise: \(timesSunrise)\nSunset: \(timesSunset)\nSolarNoon: \(timesSolarNoon)\nDayLength: \(timesDayLength)"
        }
    }
    
//    func characterName(characterName: String, characterHeight: String, characterWeight: String, characterGender: String, characterHairColor: String, characterEyeColor: String) {
//        DispatchQueue.main.async {
//            self.sunriseLabel.text = "Sunrise: \(timesSunrise)\nSunset: \(timesSunset)\nSolarNoon: \(timesSolarNoon)\nDayLength: \(timesDayLength)"
//        }
//    }
    
}






























