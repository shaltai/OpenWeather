import UIKit
import CoreLocation

class LocationDateView: UIView {
   static var shared = LocationDateView()
   var placemark: CLPlacemark?
   
   let locationNameLabel = UILabel()
   let dateLabel = UILabel()
   let formatter = DateFormatter()
   
   override private init(frame: CGRect) {
      super.init(frame: frame)
      
      setup()
   }
   
   // Setup
   func setup() {
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
