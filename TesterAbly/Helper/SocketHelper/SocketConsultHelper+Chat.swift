//
//  SocketConsultHelper+Chat.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 12/08/23.
//

import Foundation

//MARK :: [Krisna] socket Helper extension temporary for func emit for chat feature
extension SocketConsultHelper {
  
  func socketChatConnect(){
    socket.on(clientEvent: .connect) {_, _ in
      self.socket.emitWithAck("CHAT:CONNECT").timingOut(after: 3, callback: { data in
        print("ini data \(data)")
      })
    }
  }
  
  func socketChatSendText(data:MessagingSendEmit){
    self.socket.emitWithAck("CHAT:SEND_TEXT", ["_id": data._id,
                                             "consultation_id": data.consultation_id,
                                             "user_name": data.user_name,
                                             "sender":data.sender,
                                             "message":data.message,
                                             "sent_at":data.sent_at,
                                             "delivered_at":data.delivered_at,
                                             "read_at":data.read_at
                                            ]).timingOut(after: 5, callback: { data in
      print("ini send \(data)")
    })
  }
  
  func socketChatHistory(){
    self.socket.emitWithAck("CHAT:HISTORY").timingOut(after: 5, callback: { data in
      print("ini send \(data)")
    })
  }
  
}

//MARK :: [Krisna] socket Helper extension temporary for func Listener
extension SocketConsultHelper {
  
  func didReceiveChat(){
    socket.on("CHAT:RECEIVED") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      ack.with("")
      self.delegateChatConsult?.didReceiveChatMsg(data: data.first as! NSDictionary)
    }
  }
  
  func didReceivePresence(){
    socket.on("CHAT:PRESENCE_LISTEN") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      ack.with("")
      self.delegateChatConsult?.didReceiveChatPresence(data: data.first as! NSDictionary)
    }
  }
}
