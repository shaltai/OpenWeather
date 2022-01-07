import UIKit

// Text styles
enum TextStyle {
   enum Heading {
      case h1, h2, h3, h4, h5, h6
   }
   
   enum Overheading {
      case o1, o2, o3
   }
   
   enum Paragraph {
      case p1, p2, p3
   }
   case heading(level: Heading)
   case paragraph(level: Paragraph)
   case overheading(level: Overheading)
}

// Typography extension
extension NSMutableAttributedString {
   func setupAttributes(style: TextStyle,
                        align: NSTextAlignment,
                        color: UIColor) -> Self {
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = align
      
      var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: style,
                                                       NSAttributedString.Key.foregroundColor: color]
      
      switch style {
         // Heading styles
      case .heading(let level):
         paragraphStyle.lineHeightMultiple = 1.1
         attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
         // Heading levels
         switch level {
         case .h1:
            attributes[NSAttributedString.Key.kern] = 0.7
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 72, weight: .bold)
         case .h2:
            attributes[NSAttributedString.Key.kern] = 0.5
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 36, weight: .bold)
         case .h3:
            attributes[NSAttributedString.Key.kern] = 0.3
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 24, weight: .bold)
         case .h4:
            attributes[NSAttributedString.Key.kern] = 0.2
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 20, weight: .bold)
         case .h5:
            attributes[NSAttributedString.Key.kern] = 0.1
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16, weight: .bold)
         case .h6:
            attributes[NSAttributedString.Key.kern] = 0.0
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 14, weight: .bold)
         }
         // Paragraph styles
      case .paragraph(let level):
         paragraphStyle.lineHeightMultiple = 1.4
         attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
         // Paragraph levels
         switch level {
         case .p1:
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18, weight: .regular)
         case .p2:
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16, weight: .regular)
         case .p3:
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 14, weight: .regular)
         }
         
      case .overheading(let level):
         replaceCharacters(in: NSRange(location: 0, length: length),
                           with: (string as NSString).substring(with: NSRange(location: 0, length: length)).uppercased())
         
         // Overheading levels
         switch level {
         case .o1:
            attributes[NSAttributedString.Key.kern] = 3.0
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18, weight: .regular)
         case .o2:
            attributes[NSAttributedString.Key.kern] = 2.5
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16, weight: .regular)
         case .o3:
            attributes[NSAttributedString.Key.kern] = 2.0
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 14, weight: .regular)
         }
      }
      self.addAttributes(attributes, range: NSRange(location: 0, length: length))
      return self
   }
}

