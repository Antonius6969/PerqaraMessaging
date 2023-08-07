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
    @IBOutlet weak var coreMessageError: UILabelInterMedium!
    
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
                return UIColor(string: "#0376bf")
            case .filledRed:
                return UIColor(string: "#FDEEEC")
            case .filledGreen:
                return UIColor(string: "#EAFAF0")
            case .filledYoungBlue:
                return UIColor(string: "#EDF2F7")
            case .filledYellow:
                return UIColor(string: "#FFF8D4")
            case .filledWhite:
                return UIColor.white
            case .nude:
                return UIColor.clear
            case .nudeWhite:
                return UIColor(string: "#ffffff")
            case .nudeNoBorder :
                return UIColor(string: "#ffffff")
            case .disabled:
                return UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .filled:
                return UIColor(string: "#ffffff")
            case .filledRed:
                return UIColor(string: "#752C21")
            case .filledGreen:
                return UIColor(string: "#156633")
            case .filledYoungBlue:
                return UIColor(string: "#0A50A3")
            case .filledYellow:
                return UIColor(string: "#784D05")
            case .filledWhite:
                return UIColor(string: "#0376bf")
            case .nude:
                return  UIColor(string: "#0376bf")
            case .nudeWhite:
                return UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return  UIColor(string: "#0376bf")
            case .disabled:
                return UIColor(string: "#ffffff")
            case .clear:
                return UIColor(string: "#0376bf")
            case .hightlight:
                return UIColor(string: "#ffffff")
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .filled:
                return UIColor(string: "#0376bf")
            case .filledRed:
                return UIColor(string: "#FDEEEC")
            case .filledGreen:
                return UIColor(string: "#EAFAF0")
            case .filledYoungBlue:
                return UIColor(string: "#EDF2F7")
            case .filledYellow:
                return UIColor(string: "#FFF8D4")
            case .filledWhite:
                return UIColor.white
            case .nude:
                return UIColor(string: "#0376bf")
            case .nudeWhite:
                return UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return UIColor.clear
            case .disabled:
                return UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor(string: "#ffffff")
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
