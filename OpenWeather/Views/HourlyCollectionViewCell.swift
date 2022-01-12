import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
   let context = Persistance.shared.persistentContainer.viewContext
   var hourlyCoreDataArray: [Hourly] = []
   
   let timeLabel = UILabel()
   let weatherIcon = UIImageView()
   let tempLabel = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      // Fetch hourly weather data from Core Data
      do {
         hourlyCoreDataArray = try context.fetch(Hourly.fetchRequest())
         if !hourlyCoreDataArray.isEmpty {
            
            // First element
            guard let hourlyCoreData = hourlyCoreDataArray.first else { return }
            
            // Time
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            guard let time = hourlyCoreData.dt else { return }
            let timeText = formatter.string(from: time)
            timeLabel.attributedText = NSMutableAttributedString(string: timeText).setupAttributes(style: .paragraph(level: .p3),
                                                                                                   align: .left,
                                                                                                   color: .secondaryLabel)
            
            // Temperature
            let tempText = "\(Int(hourlyCoreData.temp))˚C"
            tempLabel.attributedText = NSMutableAttributedString(string: tempText).setupAttributes(style: .heading(level: .h3),
                                                                                                   align: .left,
                                                                                                   color: .secondaryLabel)
         }
      } catch let error as NSError {
         print("Error \(error.localizedDescription), \(error.userInfo)")
      }
      
      setup()
   }

   func initHourlyCollectionViewCell(data: WeatherModel.Hourly) {
      let hourlyCoreData = Hourly(context: context)
      
      // Get data from JSON and put it to Core data
      // Time
      hourlyCoreData.dt = data.dt
      
      // Weather icon
      if let imageData = try? Data(contentsOf: data.weather[0].iconURL) {
         weatherIcon.image = UIImage(data: imageData)
      }
      
      // Temperature
      hourlyCoreData.temp = data.temp
      
      // Save context
      Persistance.shared.saveContext(context: context)
   }
   
   func setup() {
      
      // Add subviews
      for view in [timeLabel, weatherIcon, tempLabel] {
         self.addSubview(view)
      }
      
      // Constraints
      timeLabel.setupEdgeConstraints(top: topAnchor,
                                     leading: leadingAnchor)
      weatherIcon.setupEdgeConstraints(top: timeLabel.bottomAnchor,
                                       bottom: tempLabel.topAnchor,
                                       leading: leadingAnchor,
                                       size: CGSize(width: 80, height: 80),
                                       padding: UIEdgeInsets(top: -8, left: -8, bottom: 0, right: 0))
      tempLabel.setupEdgeConstraints(bottom: bottomAnchor,
                                     leading: leadingAnchor)
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      setup()
   }
   
}
