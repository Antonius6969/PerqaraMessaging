//
//  MessagingService.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation

class ChattingService {
    
    let client = RestHelper()
    let url = MessagingServiceUrl()
    
}

extension ChattingService {
  
//  func postMsgSendWithFile(fileName:String,req: MessageSendFileReq, completion: @escaping(ResultStatusResp<MessageSendFileResp>) -> ()) {
//    let _ = client.postFileImage(url: url.urlSendMessage,
//                                 imgData: req.file,
//                                 fileName: "test",
//                                 responseType: MessageSendFileResp.self,
//                                 param:req,
//                                 complete: {
//          data in completion(.success(data))
//      }, errors: {
//          error in completion(.failure(error))
//      })
//  }
}
