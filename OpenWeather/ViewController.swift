import UIKit

class ViewController: UIPageViewController {
   
   var pagesArray = [UIViewController]()
   let pageControl = UIPageControl()
   let initialPage = 0
   
   let spinner = UIActivityIndicatorView(style: .large)
   let loaderView = UIVisualEffectView()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setup()
   }
   
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
      
      // Array of viewControllers
      let pageCurrentWeather = CurrentViewController()
      let pageDailyForecast = DailyTableViewController()
      pagesArray.append(pageCurrentWeather)
      pagesArray.append(pageDailyForecast)
      
      // Pass data
      showSpinner()
      WeatherLoader().loadWeather() { data in
         pageCurrentWeather.initCurrentView(data: data)
         pageCurrentWeather.supplementaryView.hourlyCollectionView.reloadData()
         pageDailyForecast.initDailyTableView(data: data)
         pageDailyForecast.tableView.reloadData()
         self.hideSpinner()
      }
      
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


// Constraints extension
extension UIView {
   func setupSizeConstraints(to view: UIView,
                             widthMultiplier: CGFloat = .zero,
                             heightMultiplier: CGFloat = .zero) {
      translatesAutoresizingMaskIntoConstraints = false
      
      widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
      heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightMultiplier).isActive = true
   }
   
   func setupCenterConstraints(to view: UIView) {
      translatesAutoresizingMaskIntoConstraints = false
      
      centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
   }
   
   func setupEdgeConstraints(top: NSLayoutYAxisAnchor? = nil,
                             trailing: NSLayoutXAxisAnchor? = nil,
                             bottom: NSLayoutYAxisAnchor? = nil,
                             leading: NSLayoutXAxisAnchor? = nil,
                             size: CGSize = .zero,
                             padding: UIEdgeInsets = .zero) {
      translatesAutoresizingMaskIntoConstraints = false
      
      if let top = top {
         topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
      }
      if let trailing = trailing {
         trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
      }
      if let bottom = bottom {
         bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
      }
      if let leading = leading {
         leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
      }
      if size.width != 0 {
         widthAnchor.constraint(equalToConstant: size.width).isActive = true
      }
      if size.height != 0 {
         heightAnchor.constraint(equalToConstant: size.height).isActive = true
      }
   }
}
