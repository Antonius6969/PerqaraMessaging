//
//  UIView+Extension.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 07/08/23.
//

import Foundation
import UIKit

extension UIView {
  public func roundCorners(_ corners: UIRectCorner = .allCorners, value: CGFloat) {
    guard corners != .allCorners else {
      layer.cornerRadius = value
      return
    }
    
    guard #available(iOS 11.0, *) else {
      let path = UIBezierPath(roundedRect: bounds,
                              byRoundingCorners: corners,
                              cornerRadii: CGSize(width: value, height: value))
      let maskLayer = CAShapeLayer()
      maskLayer.frame = bounds
      maskLayer.path = path.cgPath
      layer.mask = maskLayer
      
      return
    }
    
    layer.cornerRadius = value
    layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
  }
}
