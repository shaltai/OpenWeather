import UIKit
import CoreLocation

class LocationDateView: UIView {
   
   let locationNameLabel = UILabel()
   var cityName = String()
   var countryName = String()
   let dateLabel = UILabel()
   let formatter = DateFormatter()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setup()
   }

   
   func initLocationDateView(placemark: CLPlacemark) {
//      print (Thread.current)
      DispatchQueue.main.async { [self] in
         cityName = placemark.locality ?? "Moscow"
         countryName = placemark.country ?? "Russia"
         locationNameLabel.text = cityName + ", " + countryName
         print(self.locationNameLabel.text as Any)
      }
   }
   
   // Setup
   func setup() {
      
//      locationNameLabel.text = cityName + ", " + countryName
      locationNameLabel.textColor = .systemGray
      locationNameLabel.font = UIFont.systemFont(ofSize: 20)
      formatter.dateFormat = "EEEE, MMM d"
      dateLabel.text = formatter.string(from: Date())
      dateLabel.textColor = .systemGray
      dateLabel.textAlignment = .right
      dateLabel.font = UIFont.systemFont(ofSize: 20)
      
      // Add views
      self.addSubview(locationNameLabel)
      self.addSubview(dateLabel)
      
      // Constraints
      locationNameLabel.setupEdgeConstraints(leading: self.leadingAnchor)
      locationNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      dateLabel.setupEdgeConstraints(trailing: self.trailingAnchor)
      dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setup()
   }
}

