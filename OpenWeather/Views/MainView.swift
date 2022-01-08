import UIKit

class MainView: UIView {
   let context = Persistance.shared.persistentContainer.viewContext
   var currentCoreDataArray: [Current] = []
   var currentWeatherCoreDataArray: [CurrentWeather] = []
   
   let contentView = UIView()
   
   let currentWeatherIcon = UIImageView()
   let currentWeatherMain = UILabel()
   let currentWeatherDescription = UILabel()
   let currentTemp = UILabel()
   let currentFeelsLike = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      do {
         // Fetch current weather data from Core Data
         currentCoreDataArray = try context.fetch(Current.fetchRequest())
         currentWeatherCoreDataArray = try context.fetch(CurrentWeather.fetchRequest())
         if !currentCoreDataArray.isEmpty && !currentWeatherCoreDataArray.isEmpty {
            // Arrays first elements
            guard let currentCoreData = currentCoreDataArray.first,
                  let currentWeatherCoreData = currentWeatherCoreDataArray.first else { return }
            // Populate table with current weather data
            guard let iconURL = currentWeatherCoreData.iconURL else { return }
            // Weather Icon
            if let imageData = try? Data(contentsOf: iconURL) {
               currentWeatherIcon.image = UIImage(data: imageData)
            }
            // Main weather value
            guard let mainWeatherText = currentWeatherCoreData.main else { return }
            currentWeatherMain.attributedText = NSMutableAttributedString(string: mainWeatherText).setupAttributes(style: .paragraph(level: .p3), align: .left, color: .label)
            // Auxiliary weather description
            guard let descriptionWeatherText = currentWeatherCoreData.descr else { return }
            currentWeatherDescription.attributedText = NSMutableAttributedString(string: descriptionWeatherText).setupAttributes(style: .paragraph(level: .p3), align: .left, color: .secondaryLabel)
            // Temperature
            let tempText = "\(Int(currentCoreData.temp))˚C"
            currentTemp.attributedText = NSMutableAttributedString(string: tempText).setupAttributes(style: .heading(level: .h1), align: .left, color: .label)
            // Feels Like Temperature
            let feelsLikeText = "Feels like \(Int(currentCoreData.feels_like))˚C"
            currentFeelsLike.attributedText = NSMutableAttributedString(string: feelsLikeText).setupAttributes(style: .paragraph(level: .p3), align: .left, color: .secondaryLabel)
         }
      } catch let error as NSError {
         print("Error \(error), \(error.userInfo)")
      }
      
      setup()
   }
   
   func initMainView(data: WeatherModel) {
      let currentCoreData = Current(context: context)
      let currentWeatherCoreData = CurrentWeather(context: context)
      
      // Get data from JSON and put it to Core data
      // Weather icon
      currentWeatherCoreData.iconURL = data.current.weather.first?.iconURL
      // Weather
      currentWeatherCoreData.main = data.current.weather.first?.main
      // Weather description
      currentWeatherCoreData.descr = data.current.weather.first?.description
      // Temperature
      currentCoreData.temp = data.current.temp
      // Feels Like Temperature
      currentCoreData.feels_like = data.current.feels_like
      
      // Save context
      Persistance.shared.saveContext(context: context)
      
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
      contentView.setupSizeConstraints(to: self, widthMultiplier: 1 / 2.5, heightMultiplier: 1 / 2)
      contentView.setupCenterConstraints(to: self)
      currentWeatherIcon.setupEdgeConstraints(top: contentView.topAnchor,
                                              leading: contentView.leadingAnchor,
                                              size: CGSize(width: 80, height: 80),
                                              padding: UIEdgeInsets(top: -10, left: -10, bottom: 0, right: 0))
      currentWeatherMain.setupEdgeConstraints(top: contentView.topAnchor,
                                              leading: currentWeatherIcon.trailingAnchor)
      currentWeatherDescription.setupEdgeConstraints(top: currentWeatherMain.bottomAnchor,
                                                     leading: currentWeatherIcon.trailingAnchor)
      currentTemp.setupEdgeConstraints(top: currentWeatherDescription.bottomAnchor,
                                       trailing: contentView.trailingAnchor,
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
