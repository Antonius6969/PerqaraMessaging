//
//  SocketMessageHelper+ClientExtension.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 25/07/23.
//

import Foundation

//MARK :: [Krisna] socket Helper extension temporary for func emit for client
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
                                            ]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallToken(consultId: String,
                             clientId: String,
                             lawyerId: String) {
    self.socket.emitWithAck("CLIENT:CALL_TOKEN", ["consultation_id": consultId,
                                                  "client_id": clientId,
                                                  "lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallRequest(consultId: String,
                               clientId: String,
                               lawyerId: String,
                               call_type: String) {
    self.socket.emitWithAck("CLIENT:CALL_REQUEST", ["consultation_id": consultId,
                                                    "client_id": clientId,
                                                    "lawyer_id": lawyerId,
                                                    "call_type": consultId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallRequest(lawyerId: String,
                               camera_muted: Bool,
                               microphone_muted:Bool) {
    self.socket.emitWithAck("CLIENT:CALL_MUTED", ["lawyer_id": lawyerId,
                                                  "camera_muted": camera_muted,
                                                  "microphone_muted": microphone_muted]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallCanceled(lawyerId: String) {
    self.socket.emitWithAck("CLIENT:CALL_CANCELED", ["lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallResponse(lawyerId: String,
                                accept_call:Bool) {
    self.socket.emitWithAck("CLIENT:CALL_RESPONSE", ["lawyer_id": lawyerId,
                                                     "accept_call":accept_call]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
  
  func socketClientCallFailed(lawyerId: String) {
    self.socket.emitWithAck("CLIENT:CALL_FAILED", ["lawyer_id": lawyerId]).timingOut(after: 3, callback: { data in
      print("ini data \(data)")
    })
  }
}

//MARK :: [Krisna] socket Helper extension temporary for func Listener
extension SocketConsultHelper {
  
  func didReceiveClientChat(){
    socket.on("CHAT:RECEIVED") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientReceiveChatMsg()
    }
  }
  
  func didReceiveClientPresence(){
    socket.on("CHAT:PRESENCE_LISTEN") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientReceiveChatPresence()
    }
  }
  
  func didCallRequestNotif() {
    socket.on("CLIENT:CALL_REQUEST_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientCallRequestNotif()
    }
  }
  
  func didCallMutedNotif() {
    socket.on("CLIENT:CALL_MUTED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientCallMutedNotif()
    }
  }
  
  func didCallCanceledNotif() {
    socket.on("CLIENT:CALL_CANCELED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientCallCanceledNotif()
    }
  }
  
  func didCallRespNotif() {
    socket.on("CLIENT:CALL_RESPONSE_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientCallResponseNotif()
    }
  }
  
  func didCallFailedNotif() {
    socket.on("CLIENT:CALL_FAILED_NOTIFICATION") { data, ack in
      print("⚡️ test socket listener : ", data.first ?? "")
      self.delegateClientConsult?.didClientCallFailedNotif()
    }
  }
  
}
