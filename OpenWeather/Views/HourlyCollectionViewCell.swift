import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
   let context = Persistance.shared.persistentContainer.viewContext
   var hourlyCoreDataArray: [Hourly] = []
   
   let timeLabel = UILabel()
   let weatherIcon = UIImageView()
   let tempLabel = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }

   func initHourlyCollectionViewCell(data: WeatherModel.Hourly) {
      
      // Time
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      timeLabel.text = formatter.string(from: data.dt)
      
      // Weather
      if let imageData = try? Data(contentsOf: data.weather[0].iconURL) {
         weatherIcon.image = UIImage(data: imageData)
      }
      
      // Temperature
      tempLabel.text = "\(Int(data.temp))˚C"
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
                                       leading: leadingAnchor)
      tempLabel.setupEdgeConstraints(bottom: bottomAnchor,
                                     leading: leadingAnchor)
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      setup()
   }
   
}
