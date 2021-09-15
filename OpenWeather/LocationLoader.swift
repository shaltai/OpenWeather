import Foundation
import CoreLocation

class LocationLoader {
    private let locationManager = CLLocationManager()
    
    func loadLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Use the last reported location
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?.first
                    completionHandler(firstLocation)
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
        }
        locationManager.stopUpdatingLocation()
    }
}
