import UIKit

class DailyTableViewCell: UITableViewCell {
   private let stackView = UIStackView()
   private let formatter = DateFormatter()

   private let weatherView = UIView()
   let weatherIcon = UIImageView()
   let dateLabel = UILabel()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      setup()
   }
   
   func initDailyTableViewCell(data: WeatherModel.Daily) {
      
      // Weather icon and date
      if let imageData = try? Data(contentsOf: data.weather[0].iconURL) {
         weatherIcon.image = UIImage(data: imageData)
      }
      formatter.dateFormat = "E, d MMM"
      dateLabel.text = formatter.string(from: data.dt)

      // Temperature during the day
      let dailyDictionary: [[String: String]] = [["Morning": "\(Int(data.temp.morn))˚C"],
                                                 ["Day": "\(Int(data.temp.day))˚C"],
                                                 ["Evening": "\(Int(data.temp.eve))˚C"],
                                                 ["Night": "\(Int(data.temp.night))˚C"]]

      // Populate cell
      for view in stackView.subviews {
         view.removeFromSuperview()
      }
      
      for item in 0...dailyDictionary.count - 1 {
         let contentViews = Array(repeating: UIView(), count: dailyDictionary.count)
         // Temperature and daytime labels
         let tempLabel = UILabel()
         let daytimeLabel = UILabel()
         tempLabel.text = dailyDictionary[item].values.first
         daytimeLabel.text = dailyDictionary[item].keys.first
         // Add subviews
         contentViews[item].addSubview(tempLabel)
         contentViews[item].addSubview(daytimeLabel)
         stackView.addArrangedSubview(contentViews[item])
         // Set background color for even odd items
         contentViews[item].backgroundColor = item % 2 == 0 ? .systemGray2 : .systemGray
         // Constraints
         tempLabel.setupEdgeConstraints(top: contentViews[item].topAnchor,
                                        trailing: contentViews[item].trailingAnchor,
                                        leading: contentViews[item].leadingAnchor)
         daytimeLabel.setupEdgeConstraints(trailing: contentViews[item].trailingAnchor,
                                           bottom: contentViews[item].bottomAnchor,
                                           leading: contentViews[item].leadingAnchor)
      }

   }
   
   func setup() {

      //Setup
      backgroundColor = .clear
      weatherView.backgroundColor = .systemYellow
      stackView.distribution = .fillEqually

      // Add subviews
      addSubview(weatherView)
      weatherView.addSubview(weatherIcon)
      weatherView.addSubview(dateLabel)
      addSubview(stackView)


      // Constraints
      weatherView.setupEdgeConstraints(top: topAnchor,
                                       bottom: bottomAnchor,
                                       leading: leadingAnchor,
                                       size: CGSize(width: UIScreen.main.bounds.width / 4, height: 0),
                                       padding: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
      weatherIcon.setupEdgeConstraints(top: weatherView.topAnchor,
                                       leading: weatherView.leadingAnchor,
                                       size: CGSize(width: weatherView.frame.width, height: weatherView.frame.width))
      dateLabel.setupEdgeConstraints(bottom: bottomAnchor,
                                     leading: leadingAnchor,
                                     size: CGSize(width: UIScreen.main.bounds.width / 4, height: 0))
      stackView.setupEdgeConstraints(top: topAnchor,
                                     trailing: trailingAnchor,
                                     bottom: bottomAnchor,
                                     leading: weatherView.trailingAnchor,
                                     padding: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setup()
   }
}
