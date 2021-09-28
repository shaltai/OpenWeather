import Foundation

struct WeatherModel: Codable {
   
   // Current Weather
   struct Current: Codable {
      let temp: Double
      let feels_like: Double
      let humidity: Int
      let pressure: Int
      let uvi: Double
      let wind_speed: Double
      let wind_deg: Int
      struct Weather: Codable {
         let main: String
         let description: String
         let icon: String
         var iconURL: URL {
            let url = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: url)!
         }
      }
      let weather: [Weather]
   }
   let current: Current
   
   // Hourly forecast
   struct Hourly: Codable {
      let dt: Date
      let temp: Double
      struct Weather: Codable {
         let icon: String
         var iconURL: URL {
            let url = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: url)!
         }
      }
      let weather: [Weather]
   }
   let hourly: [Hourly]
   
   // Daily forecast
   struct Daily: Codable {
      let dt: Date
      struct Temp: Codable {
         let morn: Double
         let day: Double
         let eve: Double
         let night: Double
      }
      let temp: Temp
      struct Weather: Codable {
         let icon: String
         var iconURL: URL {
            let url = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: url)!
         }
      }
      let weather: [Weather]
   }
   let daily: [Daily]
}

