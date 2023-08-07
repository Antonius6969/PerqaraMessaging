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
    socket.on(clientEvent: .connect) {_, _ in
      self.socket.emit("LAWYER:REGISTER", ["token": token, "lawyer_id": self.clientId ?? ""])
      self.socket.on("LAWYER:REGISTER") { data, ack in
        print("ini data \(data)")
      }
    }
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
