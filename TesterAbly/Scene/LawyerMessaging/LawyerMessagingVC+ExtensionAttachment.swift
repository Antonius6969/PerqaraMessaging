//
//  LawyerMessagingVC+ExtensionAttachment.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 09/08/23.
//

import Foundation
import CoreMedia
import UIKit

extension LawyerMessagingVC: AttachmentViewProtocol {
  func didSelectFotoAttachment() {
    print("add foto pressed")
    isCameraPicker = true
    cameraPicker.checkPermissionCamera()
  }
  
  func didSelectGalleryAttachment() {
    print("add Gallery pressed")
    isCameraPicker = false
    galeryPicker.checkPermissionGalery()
  }
  
  func didSelectDocumentAttachent() {
    print("add Document pressed")
    docPicker.showDocumentPicker(vc:self)
  }
}

extension LawyerMessagingVC: AttachConfrimViewProtocol {
  func didSendAttachment(des: String, img: UIImage) {
    //self.ivAdvocateMainChat.image = img
    //let jpegData = img.jpegData(compressionQuality: 0.5)
    //self.stateLoading(state: .show)
    //self.viewModel.postSendFile(req: self.viewModel.initMessageSendFileReq(data: jpegData!, msg: des))
  }
  
  func didBackAttachment() {
    self.dismissPopUpView()
  }
  
  func didReturnAttachment() {
    if isCameraPicker {
      self.cameraPicker.checkPermissionCamera()
    } else {
      self.galeryPicker.checkPermissionGalery()
    }
  }
}

extension LawyerMessagingVC: CameraPickerProtocol {
  func openCamera() {
    self.cameraPicker.checkPermissionCamera()
  }
  
  func didAuthorizedOpenCamera() {
    self.cameraPicker.openCamera(view: self)
  }
  
  func didFailedCaptureImage() {
    DispatchQueue.main.async {
      let alertController = UIAlertController (title: "Perhatian", message: "Berikan akses Camera di Pengaturan untuk melanjutkan", preferredStyle: .alert)
      
      let cancelAction = UIAlertAction(title: "Batalkan", style: .default)  { (_) -> Void in
        //                AppState.switchToHome(completion: nil)
      }
      alertController.addAction(cancelAction)
      
      let settingsAction = UIAlertAction(title: "Pengaturan", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
          return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
          UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
            print("Settings opened: \(success)") // Prints true
          })
        }
      }
      alertController.addAction(settingsAction)
      
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
  func didFinishCaptureImage(image: UIImage) {
    self.dismissPopUpView()
    attachConfrimView.setupView(img: image)
    attachConfrimView.delegate = self
    self.showPopUpBottomView(withView: attachConfrimView, height: CGFloat(VCProperty.constantAttachConfrim),isUseNavigationBar: true)
  }
  
  func didDeniedOpenCamera() {
    //self.showError()
  }
}

extension LawyerMessagingVC: GaleryPickerProtocol {
  func openGalery() {
    self.galeryPicker.checkPermissionGalery()
  }
  
  func didAuthorizedOpenGalery() {
    self.galeryPicker.openGalery(view: self)
  }
  
  func didDeniedOpenGalery() {
    DispatchQueue.main.async {
      let alertController = UIAlertController (title: "Perhatian", message: "Berikan akses Photos di Pengaturan untuk melanjutkan", preferredStyle: .alert)
      
      let cancelAction = UIAlertAction(title: "Batalkan", style: .default)  { (_) -> Void in
        //                AppState.switchToHome(completion: nil)
      }
      alertController.addAction(cancelAction)
      
      let settingsAction = UIAlertAction(title: "Pengaturan", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
          return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
          UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
            print("Settings opened: \(success)") // Prints true
          })
        }
      }
      alertController.addAction(settingsAction)
      
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
  func didFinishSelectImage(image: UIImage) {
    self.dismissPopUpView()
    attachConfrimView.setupView(img: image)
    attachConfrimView.delegate = self
    self.showPopUpBottomView(withView: attachConfrimView, height: CGFloat(VCProperty.constantAttachConfrim),isUseNavigationBar: false)
  }
  
  func didFailedSelectImage() {
    //self.showError()
  }
}

extension LawyerMessagingVC : DocumentPickerProtocol {
  func didFinishSelectFile(urlPath: [URL]) {
    guard let url = urlPath.first else { return }
    let fileData = try? Data(contentsOf: url)
    dataDoc = fileData!
    //self.viewModel.postSendFile(req: self.viewModel.initMessageSendFileReq(data: dataDoc!, msg: ""))
  }
}
