import UIKit

class SupplementaryView: UIView {
   private let currentWeatherView = UIView()
   private let wrapperView = UIView()
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
      
      addSubviews()
      setupContentView()
      setupHourlyView()
   }
   
   func initSupplementaryView(data: WeatherModel) {
      // Pass data to hourly forecast
      hourlyCollectionView.initHourlyCollectionView(data: data)
      
      // Fill labels
      // Wind speed
      let windSpeedText = "Wind \(data.current.wind_speed) km/h, "
      windSpeed.attributedText = NSMutableAttributedString(string: windSpeedText).setupAttributes(style: .paragraph(level: .p2), align: .left, color: .label)
      // Wind direction
      let windDegText = "\(data.current.wind_deg)"
      windDeg.attributedText = NSMutableAttributedString(string: windDegText).setupAttributes(style: .paragraph(level: .p2), align: .left, color: .label)
      // Pressure
      let pressureText = "Pressure \(data.current.pressure) hPa"
      pressure.attributedText = NSMutableAttributedString(string: pressureText).setupAttributes(style: .paragraph(level: .p2), align: .left, color: .label)
      // Humidity
      let humidityText = "Humidity \(data.current.humidity) %"
      humidity.attributedText = NSMutableAttributedString(string: humidityText).setupAttributes(style: .paragraph(level: .p2), align: .left, color: .label)
      // UVI
      let uviText = "UV Index \(data.current.uvi)"
      uvi.attributedText = NSMutableAttributedString(string: uviText).setupAttributes(style: .paragraph(level: .p2), align: .left, color: .label)
   }
   
   // Add subviews
   func addSubviews() {
      addSubview(currentWeatherView)
      addSubview(hourlyCollectionView)
      
      currentWeatherView.addSubview(wrapperView)
      for label in [windSpeed, windDeg, pressure, humidity, uvi] {
         label.numberOfLines = 0
         wrapperView.addSubview(label)
      }
   }
   
   // Content
   func setupContentView() {
      
      // Setup
      backgroundColor = .systemBackground
      currentWeatherView.backgroundColor = .tertiaryLabel
      currentWeatherView.layer.cornerRadius = 8
      
      // Constraints
      currentWeatherView.setupEdgeConstraints(top: topAnchor,
                                              trailing: trailingAnchor,
                                              bottom: hourlyCollectionView.topAnchor,
                                              leading: leadingAnchor,
                                              padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
      wrapperView.centerYAnchor.constraint(equalTo: currentWeatherView.centerYAnchor).isActive = true
      wrapperView.setupEdgeConstraints(trailing: currentWeatherView.trailingAnchor,
                                       leading: currentWeatherView.leadingAnchor)
      windSpeed.setupEdgeConstraints(top: wrapperView.topAnchor,
                                     bottom: pressure.topAnchor,
                                     leading: wrapperView.leadingAnchor,
                                     padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
      windDeg.setupEdgeConstraints(top: wrapperView.topAnchor,
                                   leading: windSpeed.trailingAnchor,
                                   padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
      humidity.setupEdgeConstraints(top: wrapperView.topAnchor,
                                    bottom: uvi.topAnchor,
                                    leading: wrapperView.centerXAnchor,
                                    padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
      pressure.setupEdgeConstraints(bottom: wrapperView.bottomAnchor,
                                    leading: wrapperView.leadingAnchor,
                                    padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
      uvi.setupEdgeConstraints(bottom: wrapperView.bottomAnchor,
                               leading: wrapperView.centerXAnchor,
                               padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
   }
   
   // Hourly
   func setupHourlyView() {
      
      // Setup
      hourlyCollectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "hourlyCollectionViewCell")
      
      
      //Constraints
      hourlyCollectionView.setupEdgeConstraints(trailing: trailingAnchor,
                                                bottom: bottomAnchor,
                                                leading: leadingAnchor,
                                                padding: UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16))
      hourlyCollectionView.heightAnchor.constraint(equalTo: currentWeatherView.heightAnchor).isActive = true
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setupContentView()
      setupHourlyView()
   }
}


