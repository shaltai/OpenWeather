import Foundation
import Alamofire
import CoreLocation

class WeatherLoader {
//   let locationManager = CLLocationManager()
   
   func loadWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, completionHandler: @escaping (WeatherModel) -> Void) {
      
//      locationManager.requestWhenInUseAuthorization()
//      locationManager.startUpdatingLocation()
      
//      let lattitude = locationManager.location?.coordinate.latitude
//      let longitude = locationManager.location?.coordinate.longitude
      
//      let lattitude = locationManager.location?.coordinate.latitude ?? 55.751244
//      let longitude = locationManager.location?.coordinate.longitude ?? 37.618423
      
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
               print(error)
            }
         case .failure:
            print("Error is \(response.error!)")
         }
      }
   }
}
