//
//  MessagingService.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation

class MessagingService {
    
    let client = RestHelper()
    let url = MessagingServiceUrl()
    
}

extension MessagingService {
  
  func postMsgSendWithFile(fileName:String,req: MessageSendFile, completion: @escaping(ResultStatusResp<MessageReceiveFile>) -> ()) {
    let _ = client.postFileImage(url: url.urlSendMessage,
                                 imgData: req.file,
                                 fileName: "test",
                                 responseType: MessageReceiveFile.self,
                                 param:req,
                                 complete: {
          data in completion(.success(data))
      }, errors: {
          error in completion(.failure(error))
      })
  }
}
