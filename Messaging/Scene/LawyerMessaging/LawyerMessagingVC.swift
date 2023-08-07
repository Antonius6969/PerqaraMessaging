//
//  LawyerMessagingVC.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation
import UIKit

class LawyerMessagingVC : UIViewController {
  
  struct VCProperty {
      static let storyBoardName : String = "Main"
      static let identifierVC : String = "LawyerMessagingVCIdentifier"
  }
  
  static let storyboardName = VCProperty.storyBoardName
  static let identifierVC = VCProperty.identifierVC
  
  var routerHome : MessagingRouter?
  var vm = LawyerMessagingVM()
  var roomKey : String = ""
  var consultId : String = ""
  var clientId : String = ""
  var lawyerID : String = ""
  
  override func viewDidLoad() {
      super.viewDidLoad()
      //self.setupVM()
      //self.setupView()
      //self.setupRouter()
    SocketConsultHelper.shared.roomKey = self.roomKey
    SocketConsultHelper.shared.consultId = self.consultId
    SocketConsultHelper.shared.lawyerId = self.lawyerID
    SocketConsultHelper.shared.clientId = self.clientId
    SocketHelper.shared.connectSocket { (success) in
        print("socket is connect")
        
    }
  }
  
}
