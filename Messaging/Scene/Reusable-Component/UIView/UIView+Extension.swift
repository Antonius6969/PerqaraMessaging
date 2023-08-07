//
//  UIView+Extension.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 07/08/23.
//

import Foundation
import UIKit

extension UIView {
  
  fileprivate typealias Action = (() -> Void)?
  
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
  
  func xibSetup(nibName : String) {
      var containerView = UIView()
      containerView = loadViewFromNib(nibName: nibName)
      containerView.frame = bounds
      containerView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
      addSubview(containerView)
  }
  
  func loadViewFromNib(nibName : String) -> UIView {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      return view
  }
  
  public func addTapGestureRecognizer(action: (() -> Void)?) {
      self.isUserInteractionEnabled = true
      self.tapGestureRecognizerAction = action
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
      self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  fileprivate struct AssociatedObjectKeys {
      static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
  }
  
  fileprivate var tapGestureRecognizerAction: Action? {
      set {
          if let newValue = newValue {
              // Computed properties get stored as associated objects
              objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
          }
      }
      get {
          let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
          return tapGestureRecognizerActionInstance
      }
  }
  
  @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
      if let action = self.tapGestureRecognizerAction {
          action?()
      } else {
          print("no action")
      }
  }
}
