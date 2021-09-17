import UIKit

class HourlyCollectionView: UICollectionView {
   var data: WeatherModel?
   
   override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
      super.init(frame: frame, collectionViewLayout: layout)
      
      delegate = self
      dataSource = self
   }
   
   func initHourlyCollectionView(data: WeatherModel) {
      self.data = data
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      delegate = self
      dataSource = self
   }
}

extension HourlyCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      12
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
//      cell.backgroundColor = .systemRed
      
      let defaultHourly = WeatherModel.Hourly(dt: Date(), temp: 0.0, weather: [WeatherModel.Hourly.Weather(icon: "")])
      cell.initHourlyCollectionViewCell(data: data?.hourly[indexPath.row] ?? defaultHourly)
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let height = collectionView.bounds.height
      return CGSize(width: height / 4 * 3, height: height)
   }
   
}
