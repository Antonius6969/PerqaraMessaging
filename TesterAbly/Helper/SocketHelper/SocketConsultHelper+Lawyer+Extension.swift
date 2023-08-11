//
//  SocketConsultHelper+Lawyer+Extension.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 25/07/23.
//

import Foundation


//MARK :: [Krisna] socket Helper extension temporary for func emit for client
extension SocketConsultHelper {
  
  func socketLawyerCallToken(consultId: String,
                             clientId: String,
                             lawyerId: String) {
    self.socket.emitWithAck("LAWYER:CALL_TOKEN", ["consultation_id": consultId,
                                                  "client_id": clientId,
                                                  "lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketLawyerCallRequest(consultId: String,
                               clientId: String,
                               lawyerId: String,
                               call_type: String) {
    self.socket.emitWithAck("LAWYER:CALL_REQUEST", ["consultation_id": consultId,
                                                    "client_id": clientId,
                                                    "lawyer_id": lawyerId,
                                                    "call_type": consultId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketLawyerCallRequest(lawyerId: String,
                               camera_muted: Bool,
                               microphone_muted:Bool) {
    self.socket.emitWithAck("LAWYER:CALL_MUTED", ["lawyer_id": lawyerId,
                                                  "camera_muted": camera_muted,
                                                  "microphone_muted": microphone_muted]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketLawyerCallCanceled(lawyerId: String) {
    self.socket.emitWithAck("LAWYER:CALL_CANCELED", ["lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketLawyerCallResponse(lawyerId: String,accept_call:Bool) {
    self.socket.emitWithAck("LAWYER:CALL_RESPONSE", ["lawyer_id": lawyerId,
                                                     "accept_call":accept_call]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketLawyerCallFailed(lawyerId: String) {
    self.socket.emitWithAck("LAWYER:CALL_FAILED", ["lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
}

//MARK :: [Krisna] socket Helper extension temporary for func Listener
extension SocketConsultHelper {
  
  func didReceiveLawyerChat(){
    socket.on("CHAT:RECEIVED") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerReceiveChatMsg()
    }
  }
  
  func didReceiveLawyerPresence(){
    socket.on("CHAT:PRESENCE_LISTEN") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerReceiveChatPresence()
    }
  }
  
  func didLawyerCallRequestNotif() {
    socket.on("LAWYER:CALL_REQUEST_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerCallRequestNotif()
    }
  }
  
  func didLawyerCallMutedNotif() {
    socket.on("LAWYER:CALL_MUTED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerCallMutedNotif()
    }
  }
  
  func didLawyerCallCancelNotif() {
    socket.on("LAWYER:CALL_CANCELED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerCallCanceledNotif()
    }
  }
  
  func didLawyerCallRespNotif() {
    socket.on("LAWYER:CALL_RESPONSE_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerCallResponseNotif()
    }
  }
  
  func didLawyerCallFailedNotif() {
    socket.on("LAWYER:CALL_FAILED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateLawyerConsult?.didLawyerCallFailedNotif()
    }
  }
  
}
