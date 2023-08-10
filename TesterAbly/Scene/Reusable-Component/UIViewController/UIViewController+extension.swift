//
//  UIViewController+extension.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 09/08/23.
//

import Foundation
import UIKit

protocol PopUpBottomProtocol : class {
    func didDismiss()
}

extension UIViewController {
    
    static let tagContainer = 10000
    static let tagSubview = 10001
    static let btmSheetAnimationDuration = 0.15
    static let btmSheetAnimationCloseDuration = 0.2
    static let popUpAnimationfadeDuration = 0.2
    
    
    static let toleranceHeightOfDismissingViewIphoneStandard : CGFloat = 0.5
    static let toleranceHeightOfDismissingViewIphone7More : CGFloat = 0.35
    
    static var popUpBottomDelegate : PopUpBottomProtocol?
    
    //POPUP BOTTOM SHEET
    func showPopUpBottomView(withView: UIView, height: CGFloat , isUseNavigationBar : Bool = true) {
        
        let tagPlaceholder = UIViewController.tagContainer
        let tagSubView = UIViewController.tagSubview
        
        let viewContainer = UIView()
        viewContainer.frame = UIScreen.main.bounds
        viewContainer.tag = tagPlaceholder
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        viewContainer.addTapGestureRecognizer(action: {
            self.removePlaceHolderView()
        })
        
        let subView = withView
        subView.frame = CGRect(x: 0,
                               y: (UIScreen.main.bounds.height + height),
                               width: self.view.frame.width, height: height)
        subView.isUserInteractionEnabled = false
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureActs))
        
        var accLabel = "false"
        if isUseNavigationBar {
            accLabel = "true"
        }
        
        gesture.accessibilityLabel = accLabel
        subView.addGestureRecognizer(gesture)
        subView.tag = tagSubView
//        viewContainer.addSubview(subView)
        self.view.addSubview(viewContainer)
        self.view.addSubview(subView)
        
        var yPos : CGFloat = (UIScreen.main.bounds.height - height)
        if !isUseNavigationBar {
           yPos = yPos + 44
        }
        //Show view with animation
        UIView.animate(withDuration: UIViewController.btmSheetAnimationDuration, animations: {
            subView.frame = CGRect(x: 0,
                                   y: yPos,
                                   width: self.view.frame.width,
                                   height: height)
        }, completion: {
            finished in
            if finished {
                subView.isUserInteractionEnabled = true
            }
        })
    }
    
    func showPopUpView(withView: UIView, isUseNavigationBar : Bool = false){
        
        let tagPlaceholder = UIViewController.tagContainer
        let tagSubView = UIViewController.tagSubview
        
        let viewContainer = UIView()
        viewContainer.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        viewContainer.tag = tagPlaceholder
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        
        let subView = withView
        subView.frame = CGRect(x: self.view.frame.width * 0.1,
                               y: 0,
                               width: self.view.frame.width * 0.8, height: self.view.frame.height)
        subView.isUserInteractionEnabled = true
        subView.layer.zPosition = 2
        subView.tag = tagSubView
        
        subView.alpha = 0
        viewContainer.alpha = 0
        self.view.addSubview(viewContainer)
        self.view.addSubview(subView)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        UIView.animate(withDuration: UIViewController.popUpAnimationfadeDuration, animations: {
            subView.alpha = 1
            viewContainer.alpha = 1
        }, completion: {
            finished in
            if finished {
                self.navigationController?.navigationBar.isUserInteractionEnabled = false
                subView.isUserInteractionEnabled = true
            }
        })
    }
    
    func dismissPopUpView() {
        if let viewWithTag = self.view.viewWithTag(UIViewController.tagContainer) {
            UIView.animate(withDuration: UIViewController.popUpAnimationfadeDuration, animations: {
                viewWithTag.alpha = 0
            }, completion: {
                finished in
                if finished {
                    viewWithTag.removeFromSuperview()
                }
            })
        }

        if let subViewWithTag = self.view.viewWithTag(UIViewController.tagSubview) {
            UIView.animate(withDuration: UIViewController.popUpAnimationfadeDuration, animations: {
                subViewWithTag.alpha = 0
            }, completion: {
                finished in
                if finished {
                    subViewWithTag.removeFromSuperview()
                }
            })
        }
        
    }
    
    func dismissPopUpBottomView(){
        if let viewWithTag = self.view.viewWithTag(UIViewController.tagSubview) {
            UIView.animate(withDuration: 0.20, delay: 0, options: [.allowUserInteraction], animations: {
                viewWithTag.frame = CGRect(x: 0, y: self.view.frame.height , width: viewWithTag.frame.width, height: viewWithTag.frame.height)
            }, completion:  {
                finished in
                print(finished)
                if finished {
                    viewWithTag.isUserInteractionEnabled = true
                    self.removePlaceHolderView()
                    viewWithTag.removeFromSuperview()
                }
            })
        }
    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.height/2, width: (self.view.frame.size.width/4)*2 , height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 12)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
    }
    
   private func removePlaceHolderView(){
        if let viewWithTag = self.view.viewWithTag(UIViewController.tagContainer) {
                viewWithTag.removeFromSuperview()
            }
        if let subViewWithTag = self.view.viewWithTag(UIViewController.tagSubview) {
            subViewWithTag.removeFromSuperview()
        }
    }
    
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer, height : CGFloat , isUseNavigationBar : Bool = false) {
        let translation = recognizer.translation(in: view)
        let fullView = UIScreen.main.bounds.height
        
        if let viewWithTag = self.view.viewWithTag(UIViewController.tagSubview) {
            
            var toleranceHeight : CGFloat {
                let conditionIphone7More = UIScreen.main.bounds.height > 700
                
                if conditionIphone7More {
                    return UIViewController.toleranceHeightOfDismissingViewIphone7More
                }else {
                     return UIViewController.toleranceHeightOfDismissingViewIphoneStandard
                }
            }
            
            let minY = viewWithTag.frame.minY
            let conditionClose = translation.y > height * toleranceHeight
            let conditionUnableToTop =  Int(translation.y) + Int(height) <= Int(height)
            let conditionBackToTop = translation.y + minY > height * toleranceHeight
            let isGestureEnded = recognizer.state == .ended
            if conditionUnableToTop {
                var yPos : CGFloat = (fullView - height)
                   if !isUseNavigationBar {
                         yPos = yPos + 44
                }
                viewWithTag.frame = CGRect(x: 0,
                                           y: yPos ,
                                           width: viewWithTag.frame.width,
                                           height: viewWithTag.frame.height)
            }else if conditionClose {
                if isGestureEnded {
                    UIView.animate(withDuration: UIViewController.btmSheetAnimationCloseDuration,
                                   delay: 0, options: [.allowUserInteraction],
                                   animations: {
                                        viewWithTag.frame = CGRect(x: 0,
                                                                   y: self.view.frame.height ,
                                                                   width: viewWithTag.frame.width,
                                                                   height: viewWithTag.frame.height)
                    }, completion:  {
                        finished in
                        print(finished)
                        if finished {
                            UIViewController.popUpBottomDelegate?.didDismiss()
                            viewWithTag.isUserInteractionEnabled = true
                            self.removePlaceHolderView()
                            viewWithTag.removeFromSuperview()
                        }
                    })
                }
                
            }else if conditionBackToTop {
            
                var yPosEarly : CGFloat = (fullView - height + translation.y)
                if !isUseNavigationBar {
                      yPosEarly = yPosEarly + 44
                }
            
                viewWithTag.frame = CGRect(x: 0,
                                           y: yPosEarly,
                                           width: viewWithTag.frame.width,
                                           height: viewWithTag.frame.height)
                
                
                var yPos : CGFloat = (fullView - viewWithTag.frame.height)
                if !isUseNavigationBar {
                      yPos = yPos + 44
                }
                
                if isGestureEnded {
                    UIView.animate(withDuration: UIViewController.btmSheetAnimationDuration,
                                   delay: 0,
                                   options: [.allowUserInteraction],
                                   animations: {
                                        viewWithTag.isUserInteractionEnabled = false
                                        viewWithTag.frame = CGRect(x: 0,
                                                                   y: yPos,
                                                                   width: viewWithTag.frame.width,
                                                                   height: viewWithTag.frame.height)
                    }, completion:  {
                        finished in
                        if finished {
                            viewWithTag.isUserInteractionEnabled = true
                        }
                    })
                }
               
            }
        }
    }
    
    @objc private func panGestureActs(_ recognizer: UIPanGestureRecognizer) {
        if let viewWithTag = self.view.viewWithTag(UIViewController.tagSubview) {
            let height = viewWithTag.frame.height
            
            var isUseAccsLabelNav = false
            if recognizer.accessibilityLabel == "true"{
                isUseAccsLabelNav = true
            }
            moveView(panGestureRecognizer: recognizer, height: height, isUseNavigationBar: isUseAccsLabelNav)
        }
    }
    
    func setBackground() {
        let backgroundView: UIView = UIView(frame: CGRect(
            x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundView.tag = 100
        backgroundView.alpha = 0.4
        backgroundView.backgroundColor = UIColor.black
        self.view.addSubview(backgroundView)
    }
}
