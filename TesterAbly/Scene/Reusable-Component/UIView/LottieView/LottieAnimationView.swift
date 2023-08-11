//
//  LottieAnimationView.swift
//  astrapay
//
//  Created by Sandy Chandra on 23/07/21.
//  Copyright © 2021 Astra Digital Arta. All rights reserved.
//

import UIKit
import Lottie

@IBDesignable
class LottieAnimationView: UIView {

    enum AnimationList: String {
        case loadingState = "loadingLottie"
    }
    
    var nibName: String? = "LottieAnimationView"
    var identifierName: String = "LottieAnimationViewIdentifier"
    
    //MARK: DEBT show lottie animation, currently using hide and show view from stack view
    
    @IBOutlet weak var imgAnimation: UIImageView!
    @IBOutlet var contentView: UIView!
    
    static var defaultAnimationSpeed: CGFloat = 0.5
    static var defaultLoopMode: LottieLoopMode = .loop
    
    func setupAnimation(animation: AnimationList,
                        animationSpeed: CGFloat = LottieAnimationView.defaultAnimationSpeed,
                        loopMode: LottieLoopMode = LottieAnimationView.defaultLoopMode) {
        switch animation {
        case .loadingState:
            self.imgAnimation.isHidden = false
            imgAnimation.loadGif(name: "Perqara")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        initViewSetup()
    }
    
    func initViewSetup(){
        self.contentView.backgroundColor = .clear
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
}
