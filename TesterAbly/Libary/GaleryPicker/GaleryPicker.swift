//
//  GaleryPicker.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation
import UIKit
import Photos

protocol GaleryPickerProtocol {
    func didFinishSelectImage(image: UIImage)
    func didFailedSelectImage()
    func didAuthorizedOpenGalery()
    func didDeniedOpenGalery()
}

class GaleryPicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var picker = UIImagePickerController()
  var delegate: GaleryPickerProtocol?
  
  override init() {
    super.init()
    self.picker.delegate = self
  }
  
  func checkPermissionGalery() {
    let photos = PHPhotoLibrary.authorizationStatus()
    switch photos {
    case .authorized:
      self.delegate?.didAuthorizedOpenGalery()
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization({status in
        switch status {
        case .authorized:
          self.delegate?.didAuthorizedOpenGalery()
        case .denied:
          self.delegate?.didDeniedOpenGalery()
        case .restricted:
          self.delegate?.didDeniedOpenGalery()
        case .limited:
          self.delegate?.didDeniedOpenGalery()
        default:
          self.delegate?.didDeniedOpenGalery()
        }
      })
    default:
      self.delegate?.didDeniedOpenGalery()
    }
  }
  
  func openGalery(view: UIViewController) {
    DispatchQueue.main.async {
      self.picker.sourceType = .savedPhotosAlbum
      view.present(self.picker, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.delegate?.didFinishSelectImage(image: image)
    } else {
      self.delegate?.didFailedSelectImage()
    }
  }
}

