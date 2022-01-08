import UIKit
import CoreLocation
import Alamofire

class CurrentViewController: UIViewController {
   
   let locationDateView = LocationDateView.shared
   let stackView = UIStackView()
   let mainView = MainView()
   var supplementaryView = SupplementaryView()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      self.setupLocationDateView()
      self.setupStackView()
   }
   
   func initCurrentView(locationManager: CLLocationManager, data: WeatherModel) {
      LocationLoader.shared.loadLocation(locationManager: locationManager) { placemark in
         DispatchQueue.main.async {
            guard let placemark = placemark else { return }
            let locationText = "\(placemark.locality ?? "Moscow"), \(placemark.country ?? "Russia")"
            self.locationDateView.locationNameLabel.attributedText = NSMutableAttributedString(string: locationText).setupAttributes(style: .heading(level: .h4), align: .left, color: .secondaryLabel)
         }
      }
      mainView.initMainView(data: data)
      supplementaryView.initSupplementaryView(data: data)
   }
   
   // Location and date
   func setupLocationDateView() {
      locationDateView.backgroundColor = .systemBackground
      
      // Add views
      view.addSubview(locationDateView)
      
      // Constraints
      locationDateView.setupEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor,
                                            trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                            leading: view.safeAreaLayoutGuide.leadingAnchor,
                                            size: CGSize(width: 0,
                                                         height: locationDateView.dateLabel.intrinsicContentSize.height),
                                            padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
   }
   
   // Stack
   func setupStackView() {
      stackView.axis = .vertical
      stackView.distribution = .fillEqually
      
      // Add views
      view.addSubview(stackView)
      stackView.addArrangedSubview(mainView)
      stackView.addArrangedSubview(supplementaryView)
      
      // Constraints
      stackView.setupEdgeConstraints(top: locationDateView.bottomAnchor,
                                     trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     leading: view.safeAreaLayoutGuide.leadingAnchor)
   }
}

