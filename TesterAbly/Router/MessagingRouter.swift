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
    guard let viewcon = UIStoryboard(name:ClientMessagingVC.VCProperty.storyBoardName, bundle:nil).instantiateViewController(withIdentifier: ClientMessagingVC.VCProperty.identifierVC) as? ClientMessagingVC else {
                   print("Could not instantiate view controller with identifier of type settingView")
                   return
    }
    
    viewcon.roomKey = payload.roomKey ?? ""
    viewcon.consultId = payload.consultationId ?? ""
    viewcon.clientId = payload.clientId ?? ""
    viewcon.lawyerID = payload.lawyerId ?? ""
     
    print("\(self.vc?.navigationController)")
    
    self.vc?.navigationController?.pushViewController(viewcon, animated:true)
  }
  
  func navigateToLawyerMessaging(payload: MessagingDataRouter) {
    guard let vc = UIStoryboard(name:LawyerMessagingVC.VCProperty.storyBoardName, bundle:nil).instantiateViewController(withIdentifier: LawyerMessagingVC.VCProperty.identifierVC) as? LawyerMessagingVC else {
                   print("Could not instantiate view controller with identifier of type settingView")
                   return
    }
    
    vc.roomKey = payload.roomKey ?? ""
    vc.consultId = payload.consultationId ?? ""
    vc.clientId = payload.clientId ?? ""
    vc.lawyerID = payload.lawyerId ?? ""
    
    vc.navigationController?.pushViewController(vc, animated:true)
  }
}
