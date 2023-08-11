//
//  SocketMessageHelper.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 24/07/23.
//

import Foundation
import SocketIO

protocol SocketHelperConsultClientProtocol : AnyObject {
  //func didClientReceiveChatMsg(data:MessagingReceiveListener)
  //func didClientReceiveChatPresence(data:PresenceReceiveListener)
  func didClientReceiveChatMsg()
  func didClientReceiveChatPresence()
  func didClientCallRequestNotif()
  func didClientCallMutedNotif()
  func didClientCallCanceledNotif()
  func didClientCallResponseNotif()
  func didClientCallFailedNotif()
}

protocol SocketHelperConsultLawyerProtocol : AnyObject {
  //func didLawyerReceiveChatMsg(data:MessagingReceiveListener)
  //func didLawyerReceiveChatPresence(data:PresenceReceiveListener)
  func didLawyerReceiveChatMsg()
  func didLawyerReceiveChatPresence()
  func didLawyerCallRequestNotif()
  func didLawyerCallMutedNotif()
  func didLawyerCallCanceledNotif()
  func didLawyerCallResponseNotif()
  func didLawyerCallFailedNotif()
}

class SocketConsultHelper {
  
  static let shared = SocketConsultHelper()
  var delegateClientConsult : SocketHelperConsultClientProtocol?
  var delegateLawyerConsult : SocketHelperConsultLawyerProtocol?
  var token : String = ""
  var clientId : String = ""
  var socket: SocketIOClient!
  var roomKey: String = ""
  var consultId: String = ""
  var lawyerId: String = ""
  var isLawyer: Bool = false
  var manager : SocketManager?
  
  private init() {
    manager = createSocketManager(roomKey: self.roomKey,
                                                      consultId: self.consultId,
                                                      clientId: self.clientId,
                                                      lawyerId: self.lawyerId)
    socket = manager?.socket(forNamespace: "/consultation")
  }
  
  func createSocketManager(roomKey:String,
                           consultId:String,
                           clientId:String,
                           lawyerId:String) -> SocketManager {
    let manager = SocketManager(
          socketURL: URL(string: "https://chronos-dev.perqara.com")!,
          config: [
            .connectParams(["EIO": "4"]),
            .connectParams([
              //"token": "Bearer dsdasdsds",
              "room_key": "abcdefg",
              "consultation_id": "12",
              "client_id": "1",
              "lawyer_id": "2"
            ]),
            .forcePolling(true),
            .compress,
            .log(true)
          ]
        )
    return manager
  }
  
  func connectSocket(completion: @escaping(Bool) -> ()) {
    //disconnectSocket()
    
    socket.on(clientEvent: .disconnect) { _, _ in
      print("⚡️", "DISCONNECT")
    }
    
    socket.on(clientEvent: .connect) { _, _ in
      print("⚡️", "CONNECTED SOCKET Consult")
    }
    
    socket.on(clientEvent: .ping) { _, _ in
      print("⚡️", "PING")
    }
    
    socket.on(clientEvent: .pong) { _, _ in
      print("⚡️", "PONG")
    }
    
    socket.on(clientEvent: .disconnect) { _, _ in
      print("⚡️", "DISCONNECT")
    }
    
    socket.on(clientEvent: .error) { _, _ in
      print("⚡️", "ERROR")
    }
    
    socket.on(clientEvent: .reconnect) { _, _ in
      print("⚡️", "RECONNECT")
    }
    
    socket.on(clientEvent: .statusChange) { _, _ in
      print("⚡️", "STATUS CHANGED")
    }
//    socketConsultListenLawyer()
//    sockeConsultListenClient()
    didReceiveClientChat()
    didReceiveClientPresence()
    didReceiveLawyerChat()
    didReceiveLawyerPresence()
    
    socket.connect()
  }
  
  func sockeConsultListenClient(){
    didReceiveClientChat()
    didReceiveClientPresence()
    didCallRequestNotif()
    didCallMutedNotif()
    didCallRespNotif()
    didCallFailedNotif()
    didCallCanceledNotif()
  }
  
  func socketConsultListenLawyer(){
    
    didLawyerCallRequestNotif()
    didLawyerCallMutedNotif()
    didLawyerCallRespNotif()
    didLawyerCallFailedNotif()
    didLawyerCallCancelNotif()
  }
  
  func disconnectSocket() {
    socket.removeAllHandlers()
    socket.disconnect()
    print("socket Disconnected")
  }
  
  func checkConnection() -> Bool {
    if socket.manager?.status == .connected {
      return true
    }
    return false
  }
}
