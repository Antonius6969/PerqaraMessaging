//
//  UIButtonView.swift
//  Perqara - Clients
//
//  Created by Antonius Krisna on 29/08/22.
//

import Foundation
import UIKit

@IBDesignable
class UIButtonView: UIView {
    
    @IBOutlet weak var coreButton: UIButton!
    @IBOutlet weak var coreMessageError: UILabel!
    
    var contentView:UIView?
    @IBInspectable var nibName:String? = "UIButtonView"
    
    enum ButtonViewStyle {
        case filled
        case filledRed
        case filledGreen
        case filledYoungBlue
        case filledYellow
        case filledWhite
        case nude
        case nudeWhite
        case nudeNoBorder
        case disabled
        case clear
        case hightlight
        
        var backgroundColor: UIColor {
            switch self {
            case .filled:
              return UIColor.blue
            case .filledRed:
              return UIColor.red
            case .filledGreen:
              return UIColor.green
            case .filledYoungBlue:
              return UIColor.systemBlue
            case .filledYellow:
              return UIColor.yellow
            case .filledWhite:
                return UIColor.white
            case .nude:
                return UIColor.clear
            case .nudeWhite:
              return UIColor.white
            case .nudeNoBorder :
              return UIColor.white
            case .disabled:
              return UIColor.gray
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .filled:
              return UIColor.white
            case .filledRed:
              return UIColor.white
            case .filledGreen:
              return UIColor.white
            case .filledYoungBlue:
              return UIColor.white
            case .filledYellow:
              return UIColor.white
            case .filledWhite:
                return UIColor.blue
            case .nude:
                return UIColor.blue
            case .nudeWhite:
              return UIColor.blue
            case .nudeNoBorder :
              return UIColor.blue
            case .disabled:
              return UIColor.white
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .filled:
              return UIColor.blue
            case .filledRed:
              return UIColor.red
            case .filledGreen:
              return UIColor.green
            case .filledYoungBlue:
              return UIColor.systemBlue
            case .filledYellow:
              return UIColor.yellow
            case .filledWhite:
                return UIColor.white
            case .nude:
                return UIColor.clear
            case .nudeWhite:
              return UIColor.blue
            case .nudeNoBorder :
              return UIColor.white
            case .disabled:
              return UIColor.gray
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            }
        }
        
        var isEnable: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
        
    }
    
    override func layoutSubviews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupInit()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    private func setupInit() {
        self.coreButton.layer.cornerRadius = 8
    }
    
    func setAtomic(type: ButtonViewStyle = .filled, title: String = "", messageError: String = "") {
        self.coreButton.setTitle(title, for: .normal)
        self.coreButton.setTitleColor(type.titleColor, for: .normal)
        self.coreButton.backgroundColor = type.backgroundColor
        self.coreButton.layer.borderColor = type.borderColor.cgColor
        self.coreButton.isEnabled = type.isEnable
        self.coreButton.layer.borderWidth = 1.0
        
        if !messageError.isEmpty {
            if type.isEnable {
                self.coreMessageError.isHidden = true
            } else {
                self.coreMessageError.isHidden = false
            }
            self.coreMessageError.text = messageError
        } else {
            self.coreMessageError.isHidden = true
        }
        
    }
    
    func setAtomicButton(type: ButtonViewStyle, title: String = "", messageError: String = "") {
        self.coreButton.setTitle(title, for: .normal)
        self.coreButton.setTitleColor(type.titleColor, for: .normal)
        self.coreButton.backgroundColor = type.backgroundColor
        self.coreButton.layer.borderColor = type.borderColor.cgColor
        self.coreButton.isEnabled = type.isEnable
        self.coreButton.layer.borderWidth = 1.0
        
        if !messageError.isEmpty {
            if type.isEnable {
                self.coreMessageError.isHidden = true
            } else {
                self.coreMessageError.isHidden = false
            }
            self.coreMessageError.text = messageError
        } else {
            self.coreMessageError.isHidden = true
        }
        
    }
    
    func setCornerRadius(cornerRadius: CGFloat) {
        self.coreButton.layer.cornerRadius = cornerRadius
    }
}
