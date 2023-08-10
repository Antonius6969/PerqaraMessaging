//
//  CameraPicker.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation
import UIKit
import Photos
import AVKit

protocol CameraPickerProtocol {
  func didFinishCaptureImage(image: UIImage)
  func didFailedCaptureImage()
  func didAuthorizedOpenCamera()
  func didDeniedOpenCamera()
}

class CameraPicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var picker = UIImagePickerController()
  var delegate: CameraPickerProtocol?
  
  override init() {
    super.init()
    self.picker.delegate = self
  }
  
  func checkPermissionCamera() {
    let photos = AVCaptureDevice.authorizationStatus(for: .video)
    switch photos {
    case .authorized:
      self.delegate?.didAuthorizedOpenCamera()
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
          self.delegate?.didAuthorizedOpenCamera()
        } else {
          self.delegate?.didDeniedOpenCamera()
        }
      }
    default:
      self.delegate?.didDeniedOpenCamera()
    }
  }
  
  func openCamera(view: UIViewController) {
    DispatchQueue.main.async {
      self.picker.sourceType = .camera
      view.present(self.picker, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.delegate?.didFinishCaptureImage(image: image)
    } else {
      self.delegate?.didFailedCaptureImage()
    }
  }
}

