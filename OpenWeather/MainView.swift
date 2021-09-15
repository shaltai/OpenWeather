import UIKit

class MainView: UIView {
   let contentView = UIView()
   let currentWeatherIcon = UIImageView()
   let currentWeatherMain = UILabel()
   let currentWeatherDescription = UILabel()
   let currentTemp = UILabel()
   let currentFeelsLike = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setup()
   }
   
   func initMainView(data: WeatherModel) {
      if let imageData = try? Data(contentsOf: data.current.weather.first!.iconURL) {
         currentWeatherIcon.image = UIImage(data: imageData)
      }
      currentWeatherMain.text = data.current.weather.first?.main
      currentWeatherDescription.text = data.current.weather.first?.description
      currentTemp.text = "\(Int(data.current.temp))˚C"
      currentFeelsLike.text = "Feels like \(Int(data.current.feels_like))˚C"
   }
   
   func setup() {
      
      // Setup
      backgroundColor = .systemPurple
      contentView.backgroundColor = .systemTeal
      
      // Add subviews
      self.addSubview(contentView)
      for view in [currentWeatherIcon, currentWeatherMain, currentWeatherDescription, currentTemp, currentFeelsLike] {
         contentView.addSubview(view)
      }
      
      // Constraints
      contentView.setupSizeConstraints(to: self, widthMultiplier: 1 / 2.5, heightMultiplier: 1 / 2.5)
      contentView.setupCenterConstraints(to: self)
      currentWeatherIcon.setupEdgeConstraints(top: contentView.topAnchor,
                                              leading: contentView.leadingAnchor,
                                              size: CGSize(width: 64, height: 64),
                                              padding: UIEdgeInsets(top: -20, left: -10, bottom: 0, right: 0))
      currentWeatherMain.setupEdgeConstraints(top: contentView.topAnchor,
                                              leading: currentWeatherIcon.trailingAnchor)
      currentWeatherDescription.setupEdgeConstraints(top: currentWeatherMain.bottomAnchor,
                                                     leading: currentWeatherIcon.trailingAnchor)
      currentTemp.setupEdgeConstraints(top: currentWeatherDescription.bottomAnchor,
                                       trailing: contentView.trailingAnchor,
                                       bottom: nil,
                                       leading: contentView.leadingAnchor)
      currentFeelsLike.setupEdgeConstraints(trailing: contentView.trailingAnchor,
                                            bottom: contentView.bottomAnchor,
                                            leading: contentView.leadingAnchor)
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setup()
   }
}
