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
  var namelawyer : String = VMProperty.stringEmpty
  var nameClient : String = VMProperty.stringEmpty
  var token : String = VMProperty.stringEmpty
  var roomKey : String = VMProperty.stringEmpty
  var consultId : Int = VMProperty.intEmpty
  var clientId : String = VMProperty.stringEmpty
  var lawyerID : String = VMProperty.stringEmpty
  
  
  func initMessageSendReq(message:String) -> MessagingSendEmit {
    let messagingSendEmit = MessagingSendEmit(_id: "",
                                              consultation_id: "12",
                                              user_name: "Dewa",
                                              sender: "LAWYER",
                                              message: message,
                                              sent_at: DateFormatter.generateCurrentDate(FromTypeDate.dMMyyyHHmmss),
                                              delivered_at: DateFormatter.generateCurrentDate(FromTypeDate.dMMyyyHHmmss),
                                              read_at: DateFormatter.generateCurrentDate(FromTypeDate.dMMyyyHHmmss))
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
