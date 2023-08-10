//
//  MainMessagingVM.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation

class MainMessagingVM {
  
  var userType: Int = 1 // 1 : Client & 2 : Lawyer
  var roomKey : String = ""
  var consultId : String = ""
  var lawyerId : String = ""
  var clientId : String = ""
  
  func inittMessagingDataRouter() -> MessagingDataRouter{
    let data = MessagingDataRouter(roomKey: self.roomKey,
                                   consultationId: self.consultId,
                                   lawyerId: self.lawyerId,
                                   clientId: self.clientId)
    return data
  }
  
}
