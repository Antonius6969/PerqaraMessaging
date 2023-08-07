//
//  AttachConfrimView.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 16/06/23.
//

import Foundation
import UIKit

protocol AttachConfrimViewProtocol : class {
  func didSendAttachment(des:String,img:UIImage)
  func didBackAttachment()
  func didReturnAttachment()
}

@IBDesignable
class AttachConfrimView: UIView {
  
  @IBOutlet weak var btnReturnAttach: UIButtonView!
  @IBOutlet weak var btnCancelAttach: UIButtonView!
  @IBOutlet weak var ivConfrimAttach: UIImageView!
  @IBOutlet weak var tfDescAttach: UITextField!
  @IBOutlet weak var btnSendAttach: UIButtonView!
  
  
  struct ViewProperty{
    static let nibName = "AttachConfrimView"
    static let identifierVC = "AttachConfrimViewIdentifier"
    static let navigationTitle = "Perqara"
    static let navigationTitleBeta = "Perqara Beta"
    static let stringFlagBeta = "flagBeta"
  }
  
  var vc: UIViewController?
  var imageConfrim : UIImage?
  var delegate : AttachConfrimViewProtocol?
  
  override class func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup(nibName: AttachConfrimView.ViewProperty.nibName)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    xibSetup(nibName: AttachConfrimView.ViewProperty.nibName)
  }
  
  override func awakeFromNib() {
    xibSetup(nibName: AttachConfrimView.ViewProperty.nibName)
  }
    
  func setupView(img:UIImage){
    
    self.ivConfrimAttach.image = img
    
    self.btnReturnAttach.coreButton.addTapGestureRecognizer{
      self.delegate?.didReturnAttachment()
    }
    self.btnCancelAttach.coreButton.addTapGestureRecognizer{
      self.delegate?.didBackAttachment()
    }
    
    self.btnSendAttach.coreButton.addTapGestureRecognizer{
      self.delegate?.didSendAttachment(des: self.tfDescAttach.text ?? "", img: img)
    }
    
  }
}
