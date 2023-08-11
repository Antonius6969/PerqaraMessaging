//
//  SocketHelper+lawyer+Extension.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 25/07/23.
//

import Foundation
import SocketIO

//MARK :: [Krisna] socket Helper extension temporary for func emit
extension SocketHelper {
  
  func socketLawyerRegister(token : String, clientId : String) {
    self.socket.emitWithAck("LAWYER:REGISTER", ["token": token, "lawyer_id": clientId ?? ""]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
}

//MARK :: [Krisna] socket Helper extension temporary for func Listener
extension SocketHelper {
  
  func listenerLawyerHaveConsult() {
    socket.on("LAWYER:NEW_CONSULTATION") { data, ack in
      print("test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerReject()
    }
  }
  
  func listenerClientJoinRoom() {
    socket.on("LAWYER:JOIN_ROOM") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerJoinRoom()
    }
  }
  
  func listenerClientEndConsult() {
    socket.on("LAWYER:END_CONSULTATION_NOTIFICATION") { data, ack in
      print("test socket listener : ", data.first ?? "")
      self.delegateRoom?.didLawyerRecall()
    }
  }
  
}
