import UIKit

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
