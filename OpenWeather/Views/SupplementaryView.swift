import UIKit

class SupplementaryView: UIView {
   private let contentView = UIView()
   var hourlyCollectionView: HourlyCollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 1
      
      return HourlyCollectionView(frame: .zero, collectionViewLayout: layout)
   }()
   
   let windSpeed = UILabel()
   let windDeg = UILabel()
   let pressure = UILabel()
   let humidity = UILabel()
   let uvi = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setupContentView()
      setupHourlyView()
   }
   
   func initSupplementaryView(data: WeatherModel) {
      
      // Pass data to hourly forecast
      hourlyCollectionView.initHourlyCollectionView(data: data)
      
      // Fill labels
      windSpeed.text = "Wind \(data.current.wind_speed) km/h, "
      windDeg.text = "\(data.current.wind_deg)"
      pressure.text = "Pressure \(data.current.pressure) hPa"
      humidity.text = "Humidity \(data.current.humidity) %"
      uvi.text = "UV Index \(data.current.uvi)"
   }
   
   // Content
   func setupContentView() {
      
      // Setup
      backgroundColor = .systemBlue
      contentView.backgroundColor = .systemPink
      
      // Add subviews
      self.addSubview(contentView)
      for view in [windSpeed, windDeg, pressure, humidity, uvi] {
         contentView.addSubview(view)
      }
      
      // Constraints
      contentView.setupEdgeConstraints(top: self.topAnchor,
                                       trailing: self.trailingAnchor,
                                       leading: self.leadingAnchor,
                                       padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
      windSpeed.setupEdgeConstraints(top: contentView.topAnchor,
                                     leading: contentView.leadingAnchor)
      windDeg.setupEdgeConstraints(top: contentView.topAnchor,
                                   leading: windSpeed.trailingAnchor)
      pressure.setupEdgeConstraints(top: windSpeed.bottomAnchor,
                                    leading: contentView.leadingAnchor)
      humidity.setupEdgeConstraints(top: contentView.topAnchor,
                                    leading: contentView.centerXAnchor)
      uvi.setupEdgeConstraints(top: humidity.bottomAnchor,
                               leading: contentView.centerXAnchor)
   }
   
   // Hourly
   func setupHourlyView() {
      
      // Setup
//      hourlyCollectionView.backgroundColor = .systemYellow
      hourlyCollectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "hourlyCollectionViewCell")
      
      // Add subviews
      self.addSubview(hourlyCollectionView)
      
      //Constraints
      hourlyCollectionView.setupEdgeConstraints(top: contentView.bottomAnchor,
                                                trailing: self.trailingAnchor,
                                                bottom: self.bottomAnchor,
                                                leading: self.leadingAnchor,
                                                padding: UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16))
      hourlyCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setupContentView()
      setupHourlyView()
   }
}


