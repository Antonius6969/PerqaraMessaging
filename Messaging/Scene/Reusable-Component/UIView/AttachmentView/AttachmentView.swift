//
//  AttachmentView.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 12/06/23.
//

import Foundation
import UIKit

protocol AttachmentViewProtocol : class {
  func didSelectFotoAttachment()
  func didSelectGalleryAttachment()
  func didSelectDocumentAttachent()
}

@IBDesignable
class AttachmentView: UIView {
  
  @IBOutlet weak var btnImgFotoAttachment: UIButtonView!
  @IBOutlet weak var btnLblFotoAttachment: UIButtonView!
  
  @IBOutlet weak var btnImgGalleryAttachment: UIButtonView!
  @IBOutlet weak var btnLblGalleryAttachment: UIButtonView!
  
  @IBOutlet weak var btnImgDocumentAttachment: UIButtonView!
  @IBOutlet weak var btnLblDocumentAttachment: UIButtonView!
  
  
  struct ViewProperty{
    static let nibName = "AttachmentView"
    static let identifierVC = "AttachmentViewIdentifier"
    static let navigationTitle = "Perqara"
    static let navigationTitleBeta = "Perqara Beta"
    static let stringFlagBeta = "flagBeta"
  }
  
  var client : DataOPClient?
  var vc: UIViewController?
  var delegate : AttachmentViewProtocol?
  
  override class func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup(nibName: AttachmentView.ViewProperty.nibName)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    xibSetup(nibName: AttachmentView.ViewProperty.nibName)
  }
  
  override func awakeFromNib() {
    xibSetup(nibName: AttachmentView.ViewProperty.nibName)
  }
  
  func setupView(){
    
    self.btnImgFotoAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectFotoAttachment()
    }
    self.btnLblFotoAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectFotoAttachment()
    }
    
    self.btnImgGalleryAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectGalleryAttachment()
    }
    self.btnLblGalleryAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectGalleryAttachment()
    }
    
    self.btnImgDocumentAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectDocumentAttachent()
    }
    self.btnLblDocumentAttachment.coreButton.addTapGestureRecognizer{
      self.delegate?.didSelectDocumentAttachent()
    }
  }
}
