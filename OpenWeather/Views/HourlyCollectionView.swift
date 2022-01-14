import UIKit

class HourlyCollectionView: UICollectionView {
   let context = Persistance.shared.persistentContainer.viewContext
   
   override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
      super.init(frame: frame, collectionViewLayout: layout)
      
      delegate = self
      dataSource = self
   }
   
   func initHourlyCollectionView(data: WeatherModel) {
      
      // Get data from JSON and put it to Core data
      for hour in data.hourly[0...11] {
         let hourlyCoreData = Hourly(context: context)
         let hourlyWeatherCoreData = HourlyWeather(context: context)

         // Time
         hourlyCoreData.dt = hour.dt
         
         // Weather icon
         hourlyWeatherCoreData.iconURL = hour.weather.first?.iconURL
         
         // Temperature
         hourlyCoreData.temp = hour.temp
         
         // Save context
         Persistance.shared.saveContext(context: context)
      }
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
      
      // Fetch hourly weather data from Core Data
      do {
         let hourlyCoreDataArray: [Hourly] = try context.fetch(Hourly.fetchRequest())
         let hourlyWeatherCoreDataArray: [HourlyWeather] = try context.fetch(HourlyWeather.fetchRequest())

         if !hourlyCoreDataArray.isEmpty && !hourlyWeatherCoreDataArray.isEmpty {
            cell.initHourlyCollectionViewCell(data: hourlyCoreDataArray[indexPath.row], dataWeather: hourlyWeatherCoreDataArray[indexPath.row])
         }
         
      } catch let error as NSError {
         print("Error \(error.localizedDescription), \(error.userInfo)")
      }
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let height = collectionView.bounds.height
      return CGSize(width: height / 4 * 3, height: height)
   }
   
}
