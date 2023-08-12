//
//  MessagingRouter.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation
import UIKit

class MessagingRouter {
  
  let vc : UIViewController?
  
  init(viewController : UIViewController) {
    self.vc = viewController
  }
  
  func navigateToClientMessaging(payload: MessagingDataRouter) {
    guard let vc = UIStoryboard(name:ClientMessagingVC.VCProperty.storyBoardName, bundle:nil).instantiateViewController(withIdentifier: ClientMessagingVC.VCProperty.identifierVC) as? ClientMessagingVC else {
                   print("Could not instantiate view controller with identifier of type settingView")
                   return
    }
    
    vc.vm.roomKey = payload.roomKey ?? ""
    vc.vm.consultId = payload.consultationId ?? ""
    vc.vm.clientId = payload.clientId ?? ""
    vc.vm.clientName = payload.clientName ?? "" 
    vc.vm.lawyerID = payload.lawyerId ?? ""
    vc.vm.lawyerName = payload.lawyerName ?? ""
     
    print("\(self.vc?.navigationController)")
    
    self.vc?.navigationController?.pushViewController(vc, animated:true)
  }
  
  func navigateToLawyerMessaging(payload: MessagingDataRouter) {
    guard let vc = UIStoryboard(name:LawyerMessagingVC.VCProperty.storyBoardName, bundle:nil).instantiateViewController(withIdentifier: LawyerMessagingVC.VCProperty.identifierVC) as? LawyerMessagingVC else {
                   print("Could not instantiate view controller with identifier of type settingView")
                   return
    }
    
    vc.vm.roomKey = payload.roomKey ?? ""
    vc.vm.consultId = payload.consultationId ?? ""
    vc.vm.clientId = payload.clientId ?? ""
    vc.vm.clientName = payload.clientName ?? ""
    vc.vm.lawyerID = payload.lawyerId ?? ""
    vc.vm.lawyerName = payload.lawyerName ?? ""
    
    self.vc?.navigationController?.pushViewController(vc, animated:true)
  }
}
