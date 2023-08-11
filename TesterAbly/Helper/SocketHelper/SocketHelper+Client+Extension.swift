//
//  SocketHelper+Client+Extension.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 25/07/23.
//

import Foundation
import SocketIO

//MARK :: [Krisna] socket Helper extension temporary for func emit
extension SocketHelper {
  
  func socketClientRegister(token : String, clientId : String) {
    self.socket.emitWithAck("CLIENT:REGISTER", ["token": token, "client_id": clientId ?? ""]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
}

//MARK :: [Krisna] socket Helper extension temporary for func Listener
extension SocketHelper {
  
  func listenerLawyerJoinRoom() {
    socket.on("CLIENT:JOIN_ROOM") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerJoinRoom()
    }
  }
  
  func listenerLawyerReject() {
    socket.on("CLIENT:LAWYER_REJECT_CONSULTATION") { data, ack in
      print("test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerReject()
    }
  }
  
  func listenerLawyerRecall() {
    socket.on("CLIENT:LAWYER_IS_RECALLED") { data, ack in
      print("test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerRecall()
    }
  }
  
  func listenerUpdateOnline() {
    socket.on("CLIENT:UPDATE_ONLINE_LAWYER_LIST") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateHome?.didUpdateOnlineLawyer()
    }
  }
  
}
