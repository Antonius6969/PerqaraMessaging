//
//  MainMessagingVC.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation
import UIKit

class MainMessagingVC : UIViewController {
  
  @IBOutlet weak var SegmentControlUserType: UISegmentedControl!
  @IBOutlet weak var textFieldRoomKeyMessaging: UITextField!
  @IBOutlet weak var textFieldConsultIdMessaging: UITextField!
  @IBOutlet weak var textFieldLawyerIdMessaging: UITextField!
  @IBOutlet weak var textFieldClientIdMessaging: UITextField!
  
  struct VCProperty {
      static let storyBoardName : String = "Main"
      static let identifierVC : String = "MainMessagingVCIdentifier"
  }
  
  static let storyboardName = VCProperty.storyBoardName
  static let identifierVC = VCProperty.identifierVC
  
  var vm = MainMessagingVM()
  var router : MessagingRouter?
  var isFoundProvider: Bool = false
  
  override func viewDidLoad() {
      super.viewDidLoad()
    //self.setupVM()
      self.setupView()
      self.setupRouter()
  }
  
  func setupVM(){
//    SocketConsultHelper.shared.delegateClientConsult = self
  }
  
  func setupView() {
    self.textFieldRoomKeyMessaging.addTarget(self, action: #selector(tfRoomKeyDidChange(textField:)), for: .editingChanged)
    self.textFieldConsultIdMessaging.addTarget(self, action: #selector(tfConsultIdDidChange(textField:)), for: .editingChanged)
    self.textFieldLawyerIdMessaging.addTarget(self, action: #selector(tfLawyerIdDidChange(textField:)), for: .editingChanged)
    self.textFieldClientIdMessaging.addTarget(self, action: #selector(tfClientIdDidChange(textField:)), for: .editingChanged)
  }
  
  func setupRouter(){
    self.router = MessagingRouter(viewController: self)
  }
  
  @IBAction func btnActionConnectMessaging(_ sender: Any) {
    self.router?.navigateToClientMessaging(payload: vm.inittMessagingDataRouter())
//    if vm.userType == 1 {
//      self.router?.navigateToClientMessaging(payload: vm.inittMessagingDataRouter())
//    } else {
//      self.router?.navigateToLawyerMessaging(payload: vm.inittMessagingDataRouter())
//    }
  }
}

extension MainMessagingVC {
  @objc func tfRoomKeyDidChange(textField: UITextField) {
    self.vm.roomKey = textField.text ?? ""
  }
  
  @objc func tfConsultIdDidChange(textField: UITextField) {
    self.vm.consultId = textField.text ?? ""
  }
  
  @objc func tfLawyerIdDidChange(textField: UITextField) {
    self.vm.lawyerId = textField.text ?? ""
  }
  
  @objc func tfClientIdDidChange(textField: UITextField) {
    self.vm.clientId = textField.text ?? ""
  }
}
