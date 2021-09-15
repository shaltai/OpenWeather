import UIKit

class DailyTableViewController: UITableViewController {
   var data: WeatherModel?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
   }
   
   func initDailyTableView(data: WeatherModel) {
      self.data = data
   }
   
   func setup() {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.allowsSelection = false
      tableView.separatorStyle = .none
      view.backgroundColor = .systemTeal
      tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: "dailyTableViewCell")
   }
   
   // Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "dailyTableViewCell", for: indexPath) as! DailyTableViewCell

      let defaultDaily = WeatherModel.Daily(dt: Date(),
                                                  temp: WeatherModel.Daily.Temp(morn: 0, day: 0, eve: 0, night: 0),
                                                  weather: [WeatherModel.Daily.Weather(icon: "")])
      cell.initDailyTableViewCell(data: data?.daily[indexPath.row] ?? defaultDaily)
      return cell
   }
   
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return (view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.top * 1.5) / 5
   }

   
}
