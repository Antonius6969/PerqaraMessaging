//
//  ClientMessagingVM.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation

class ClientMessagingVM {
  
  struct VMProperty {
    //static let constString = StringConstant()
    static let intEmpty = 0
  }
  
  let chattingService = ChattingService()
  //var advocate : Advocate?
  
//  var username : String = VMProperty.constString.stringEmpty
//  var name : String = VMProperty.constString.stringEmpty
//  var delegate : MenuLawConsultVMProtocol?
//  var password : String = VMProperty.constString.stringEmpty
//  var client : DataOPClient?
//  var roomKey : String = VMProperty.constString.stringEmpty
//  var tokenAbly : String = VMProperty.constString.stringEmpty
  var consultId : Int = VMProperty.intEmpty
  var clientId : String = ""
  var lawyerID : String = ""
  
  func initMessageSendFileReq(data:Data,msg:String) -> MessageSendFile {
    let resultDate = DateFormatter.generateCurrentDate(FromTypeDate.dMMyyyHHmmss)
    let msgFileSend = MessageSendFile(authorized_token: "self.tokenAbly",
                                         room_key: "self.roomKey",
                                         message: msg,
                                         file: data,
                                         send_time: resultDate)
    return msgFileSend
  }
  
//  func postSendFile(req:MessageSendFile){
//    chattingService.postMsgSendWithFile(fileName: "test", req: req, completion: {
//      res in
//      switch res {
//      case .failure(let err):
//        self._liveFailurePostMessageSendFile.onNext(err)
//        break
//      case .success(let resp):
//        self._liveSuccessPostMessageSendFile.onNext(resp)
//        break
//      }
//    })
//  }
  
}
