import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
   
   let timeLabel = UILabel()
   let weatherIcon = UIImageView()
   let tempLabel = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setup()
   }
   
   func initHourlyCollectionViewCell(data: Hourly, dataWeather: HourlyWeather) {
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      
      // Time
      let timeText = formatter.string(from: data.dt)
      timeLabel.attributedText = NSMutableAttributedString(string: timeText).setupAttributes(style: .paragraph(level: .p3),
                                                                                             align: .left,
                                                                                             color: .secondaryLabel)
      
      // Weather icon
      guard let iconURL = dataWeather.iconURL else { return }
      if let imageData = try? Data(contentsOf: iconURL) {
         weatherIcon.image = UIImage(data: imageData)
      }
      
      // Temperature
      let tempText = "\(Int(data.temp))˚C"
      tempLabel.attributedText = NSMutableAttributedString(string: tempText).setupAttributes(style: .heading(level: .h3),
                                                                                             align: .left,
                                                                                                color: .secondaryLabel)
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
