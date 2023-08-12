//
//  ClientMessagingVC+ExtensionProtocol.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 10/08/23.
//

import Foundation
import UIKit
import CoreMedia

extension ClientMessagingVC : SocketHelperConsultChatProtocol {
  func didReceiveChatMsg(data: NSDictionary) {
    var jsonStringFix : String = ""
    let dataDict = data as! NSDictionary
    let jsonData = try! JSONSerialization.data(withJSONObject: dataDict, options: JSONSerialization.WritingOptions.prettyPrinted)
    let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    if jsonString.contains("\n  \"file\" : {\n\n  },") {
      jsonStringFix = jsonString.replacingOccurrences(of: "\n  \"file\" : {\n\n  },", with: "")
    } else {
      jsonStringFix = jsonString
    }
    do {
      let jsonDataFix = jsonStringFix.data(using: .utf8)!
      let decoder = JSONDecoder()
      let dataFix = try? decoder.decode(MessagingReceiveListener.self, from: jsonDataFix)
      messages.append(dataFix ?? MessagingReceiveListener())
      messagesTableView.reloadData()
      scrollToBottom(self.messagesTableView)
    } catch {
      print("error convert")
    }
    print("CLient Receive Chat Msg")
  }
  
  func didReceiveChatPresence(data: NSDictionary) {
    print("CLient Receive Chat Presence")
  }
  
  
}

extension ClientMessagingVC : SocketHelperConsultClientProtocol {
  func didClientCallRequestNotif() {
    print("CLient Receive Call req notif")
  }
  
  func didClientCallMutedNotif() {
    print("CLient Receive Call muted notif")
  }
  
  func didClientCallCanceledNotif() {
    print("CLient Receive Call canceled notif")
  }
  
  func didClientCallResponseNotif() {
    print("CLient Receive Call response notif")
  }
  
  func didClientCallFailedNotif() {
    print("CLient Receive Call failed notif")
  }
}

extension ClientMessagingVC : ClientMessagingAttachmentService {
  func didSuccesSendAttachment() {
    self.stateLoading(state: .dismiss)
    self.messagesTableView.reloadData()
    self.scrollToBottom(self.messagesTableView)
  }
  
  func didFailureSendAttachment(err: Err) {
    self.stateLoading(state: .dismiss)
    Alert.show(title: .errorTitle, msg: err.message)
  }
}

extension ClientMessagingVC: AttachmentViewProtocol {
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

extension ClientMessagingVC: AttachConfrimViewProtocol {
  func didSendAttachment(des: String, img: UIImage) {
    self.ivAdvocateMainChat.image = img
    let jpegData = img.jpegData(compressionQuality: 0.5)
    self.stateLoading(state: .show)
    self.vm.postSendFile(req: self.vm.initMessageSendFileReq(data: jpegData!, msg: des))
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

extension ClientMessagingVC: CameraPickerProtocol {
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

extension ClientMessagingVC: GaleryPickerProtocol {
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

extension ClientMessagingVC : DocumentPickerProtocol {
  func didFinishSelectFile(urlPath: [URL]) {
    guard let url = urlPath.first else { return }
    let fileData = try? Data(contentsOf: url)
    dataDoc = fileData!
    self.vm.postSendFile(req: self.vm.initMessageSendFileReq(data: dataDoc!, msg: ""))
  }
}

