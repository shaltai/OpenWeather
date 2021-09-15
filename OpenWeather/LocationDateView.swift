import UIKit
import CoreLocation

class LocationDateView: UIView {
    
    // Variables
    let locationNameLabel = UILabel()
    let dateLabel = UILabel()
    let formatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // Setup
    func setup() {
        LocationLoader().loadLocation { [self] location in
            guard let cityName = location?.locality,
                  let countryName = location?.country else { return }
            locationNameLabel.text = countryName + ", " + cityName
        }
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
}


