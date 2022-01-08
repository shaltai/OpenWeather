import UIKit
import CoreLocation

class ViewController: UIPageViewController {
   
   let pageCurrentWeather = CurrentViewController()
   let pageDailyForecast = DailyTableViewController()
   var pagesArray = [UIViewController]()
   let pageControl = UIPageControl()
   let initialPage = 0
   
   let spinner = UIActivityIndicatorView(style: .large)
   let loaderView = UIVisualEffectView()
   let locationManager = CLLocationManager()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      checkLocationService()
      setup()
   }
   
   // Pass data
   func passData() {
      WeatherLoader.shared.location = locationManager.location
      WeatherLoader.shared.loadWeather() { [self] data in
         pageCurrentWeather.initCurrentView(locationManager: locationManager, data: data)
         pageCurrentWeather.supplementaryView.hourlyCollectionView.reloadData()
         pageDailyForecast.initDailyTableView(data: data)
         pageDailyForecast.tableView.reloadData()
         hideSpinner()
      }
   }
   
   // Location
   func checkLocationService() {
      
      // Is location enabled
      if CLLocationManager.locationServicesEnabled() {
         
         // Loader
//         showSpinner()
         locationManager.delegate = self
         checkLocationAuthorization()
         
      } else {
         
         let alert = UIAlertController(title: "Location Services are Disabled",
                                       message: "Turn on location services to allow OpenWeather to determine your location",
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK",
                                       style: .cancel))
         DispatchQueue.main.async {
            self.present(alert, animated: true)
         }
      }
      // Stop updating location
      locationManager.stopUpdatingLocation()
   }
   
   // Is app authorized
   func checkLocationAuthorization() {
      switch locationManager.authorizationStatus {
      case .authorizedWhenInUse:
         locationManager.startUpdatingLocation()
         passData()
      case .denied:
         break
      case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
      default:
         break
      }
   }
   
   // Show/hide loader
   func showSpinner() {
      
      // Background
      loaderView.clipsToBounds = true
      loaderView.effect = UIBlurEffect(style: .dark)
      
      // Spinner
      spinner.color = .white
      
      // Subviews
      view.addSubview(loaderView)
      loaderView.contentView.addSubview(spinner)
      spinner.startAnimating()
      
      // Constraints
      loaderView.setupEdgeConstraints(top: view.topAnchor,
                                      trailing: view.trailingAnchor,
                                      bottom: view.bottomAnchor,
                                      leading: view.leadingAnchor)
      spinner.setupCenterConstraints(to: loaderView)
      spinner.setupEdgeConstraints(size: CGSize(width: 80, height: 80))
   }
   
   func hideSpinner() {
      spinner.stopAnimating()
      loaderView.removeFromSuperview()
   }
   
   func setup() {
      
      // Add views
      pagesArray.append(pageCurrentWeather)
      pagesArray.append(pageDailyForecast)
      
      dataSource = self
      delegate = self
      
      // Setup
      pageControl.addTarget(self, action: #selector(handleSwipe(_:)), for: .valueChanged)
      pageControl.numberOfPages = pagesArray.count
      pageControl.currentPage = initialPage
      pageControl.currentPageIndicatorTintColor = .white
      view.addSubview(pageControl)
      
      // Set initial viewController
      setViewControllers([pagesArray[initialPage]], direction: .forward, animated: true, completion: nil)
      
      // Constraints
      pageControl.setupEdgeConstraints(trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                       leading: view.safeAreaLayoutGuide.leadingAnchor,
                                       size: CGSize(width: 0, height: 16))
      view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 0.5).isActive = true
      
   }
   
   @objc func handleSwipe(_ sender: UIPageControl) {
      setViewControllers([pagesArray[initialPage]], direction: .forward, animated: true, completion: nil)
   }
}

// Pagination
extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let curentIndex = pagesArray.firstIndex(of: viewController) else { return nil }
      
      if curentIndex == 0 {
         return pagesArray.last
      } else {
         return pagesArray[curentIndex - 1]
      }
   }
   
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let currentIndex = pagesArray.firstIndex(of: viewController) else { return nil }
      
      if currentIndex < pagesArray.count - 1 {
         return pagesArray[currentIndex + 1]
      } else {
         return pagesArray.first
      }
   }
   
   func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      guard let viewControllers = pageViewController.viewControllers else { return }
      guard let currentIndex = pagesArray.firstIndex(of: viewControllers[0]) else { return }
      
      pageControl.currentPage = currentIndex
   }
}

extension ViewController: CLLocationManagerDelegate {
   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      if manager.authorizationStatus == .authorizedWhenInUse {
         checkLocationAuthorization()
      }
   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      checkLocationAuthorization()
   }
}

