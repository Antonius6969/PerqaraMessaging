//
//  MainMessagingVM.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation

class MainMessagingVM {
  
  var userType: Int = 0 // 0 : Lawyer & 1 : Client
  var roomKey : String = ""
  var consultId : String = ""
  var lawyerId : String = ""
  var lawyerName : String = ""
  var clientId : String = ""
  var clientName : String = ""
  
  func inittMessagingDataRouter() -> MessagingDataRouter{
    let data = MessagingDataRouter(roomKey: self.roomKey,
                                   consultationId: self.consultId,
                                   lawyerId: self.lawyerId,
                                   lawyerName: self.lawyerName,
                                   clientId: self.clientId,
                                   clientName: self.clientName)
    return data
  }
  
}
