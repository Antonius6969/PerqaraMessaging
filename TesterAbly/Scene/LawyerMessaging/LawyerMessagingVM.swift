//
//  LawyerMessagingVM.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation

protocol LawyerMessagingAttachmentService {
  func didSuccesSendAttachment()
  func didFailureSendAttachment(err: Err)
}

class LawyerMessagingVM {
  
  struct VMProperty {
    static let stringEmpty = ""
    static let intEmpty = 0
  }
  
  let chattingService = MessagingService()
  var delegateAttachmentService : LawyerMessagingAttachmentService?
  var token : String = VMProperty.stringEmpty
  var roomKey : String = VMProperty.stringEmpty
  var consultId : String = VMProperty.stringEmpty
  var clientId : String = VMProperty.stringEmpty
  var clientName : String = VMProperty.stringEmpty
  var lawyerID : String = VMProperty.stringEmpty
  var lawyerName : String = VMProperty.stringEmpty
  
  
  func initMessageSendReq(message:String) -> MessagingSendEmit {
    let messagingSendEmit = MessagingSendEmit(_id: "",
                                              consultation_id: self.consultId,
                                              user_name: self.lawyerName,
                                              sender: "LAWYER",
                                              message: message,
                                              sent_at: "\(Date().currentTimeMillis())",
                                              delivered_at: "\(Date().currentTimeMillis())",
                                              read_at: "\(Date().currentTimeMillis())")
    return messagingSendEmit
  }
  
  func initMessageSendFileReq(data:Data,msg:String) -> MessageSendFile {
    let resultDate = DateFormatter.generateCurrentDate(FromTypeDate.dMMyyyHHmmss)
    let msgFileSend = MessageSendFile(authorized_token: token,
                                         room_key: roomKey,
                                         message: msg,
                                         file: data,
                                         send_time: resultDate)
    return msgFileSend
  }
  
  func postSendFile(req:MessageSendFile){
    chattingService.postMsgSendWithFile(fileName: "test", req: req, completion: {
      res in
      switch res {
      case .failure(let err):
        self.delegateAttachmentService?.didFailureSendAttachment(err: err)
        break
      case .success(let resp):
        self.delegateAttachmentService?.didSuccesSendAttachment()
        break
      }
    })
  }
}
