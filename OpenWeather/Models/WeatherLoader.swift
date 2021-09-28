import Foundation
import Alamofire
import CoreLocation

class WeatherLoader {
   static let shared = WeatherLoader()
   var location: CLLocation?

   func loadWeather(completionHandler: @escaping (WeatherModel) -> Void) {
      
      guard let lattitude = location?.coordinate.latitude else { return }
      guard let longitude = location?.coordinate.longitude else { return }
      
      let key = "898bab3779babd3f2ebf7ce59326504e"
      let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lattitude)&lon=\(longitude)&units=metric&exclude=minutely,alerts&appid=\(key)"
      
      AF.request(url).validate().responseJSON { response in
         guard let data = response.data else { return }
         
         switch response.result {
         case .success:
            do {
               let value = try JSONDecoder().decode(WeatherModel.self, from: data)
               DispatchQueue.main.async {
                  completionHandler(value)
               }
            } catch {
               print("Error is \(error)")
            }
         case .failure:
            print("Error is \(response.error!)")
         }
      }
   }
}
