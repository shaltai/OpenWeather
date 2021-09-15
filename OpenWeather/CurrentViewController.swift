import UIKit
import CoreLocation
import Alamofire

class CurrentViewController: UIViewController {
   
   private let locationDateView = LocationDateView()
   private let stackView = UIStackView()
   private let mainView = MainView()
   var supplementaryView = SupplementaryView()
   private var dailyTableView = DailyTableViewController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupLocationDateView()
      setupStackView()
   }
   
   func initCurrentView(data: WeatherModel) {
      mainView.initMainView(data: data)
      supplementaryView.initSupplementaryView(data: data)
   }
   
   // Location and date
   func setupLocationDateView() {
      locationDateView.backgroundColor = .systemYellow
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

