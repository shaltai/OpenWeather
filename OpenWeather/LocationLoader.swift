import Foundation
import CoreLocation

class LocationLoader {
   
   func loadLocation(locationManager: CLLocationManager, completionHandler: @escaping (CLPlacemark?) -> Void ) {
      
      // Use the last reported location
      if let lastLocation = locationManager.location {
         let geocoder = CLGeocoder()
         // Look up the location and pass it to the completion handler
         geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { placemarks, error in
            if error == nil {
               let firstLocation = placemarks?.first
//               DispatchQueue.main.async {
                  completionHandler(firstLocation)
//               }
            }
            else {
               // An error occurred during geocoding
               completionHandler(nil)
            }
         })
      }
      else {
         // No location was available
         completionHandler(nil)
         print("No location was available")
      }
      locationManager.stopUpdatingLocation()
   }
}
