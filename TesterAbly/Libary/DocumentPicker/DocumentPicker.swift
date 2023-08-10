//
//  DocumentPicker.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

protocol DocumentPickerProtocol {
  func didFinishSelectFile(urlPath: [URL])
}

class DocumentPicker: NSObject,UIDocumentPickerDelegate {
  
  var delegate : DocumentPickerProtocol?
  
  func showDocumentPicker(vc:UIViewController) {
    let supportedTypes: [UTType] = [UTType.pdf]
    let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
    pickerViewController.delegate = vc as! any UIDocumentPickerDelegate
    pickerViewController.allowsMultipleSelection = false
    pickerViewController.shouldShowFileExtensions = true
    vc.present(pickerViewController, animated: true, completion: nil)
  }
}

extension DocumentPicker {

  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    print("Files picked")
    self.delegate?.didFinishSelectFile(urlPath: urls)
  }
}
