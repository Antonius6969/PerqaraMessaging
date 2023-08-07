//
//  SocketHelper.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 02/05/23.
//

import Foundation
import SocketIO

protocol SocketHelperListenerRoomProtocol : AnyObject {
  func didLawyerJoinRoom()
  func didLawyerReject()
  func didLawyerRecall()
}

protocol SocketHelperListenerHomeProtocol : AnyObject {
  func didUpdateOnlineLawyer()
}

class SocketHelper {
  
  static let shared = SocketHelper()
  var delegateRoom : SocketHelperListenerRoomProtocol?
  var delegateHome : SocketHelperListenerHomeProtocol?
  var token = Prefs.getToken()
  var clientId = Prefs.getClient()?.relation?.id
  var socket: SocketIOClient!
  var manager = SocketManager(
    socketURL: URL(string: "\(socketBaseUrl)")!,
    config: [
      .connectParams(["EIO": "4"]),
      .forcePolling(true),
      .compress,
      .log(true)
    ]
  )
  
  private init() {
    socket = manager.defaultSocket
  }
  
  func connectSocket(completion: @escaping(Bool) -> ()) {
    disconnectSocket()
    
    socket.on(clientEvent: .disconnect) { _, _ in
      print("⚡️", "DISCONNECT")
    }
    
    socket.on(clientEvent: .connect) { _, _ in
      print("⚡️", "CONNECTED")
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
    
    listenerUpdateOnline()
    //listenerJoinRoom()
    listenerLawyerReject()
    listenerLawyerRecall()
    
    socket.connect()
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



extension SocketHelper {
  
  enum Events {
    
    case register
    case consult_timeout
    case consultation_timeout
    case recall_lawyer
    case choose_other_lawyer
    
    var emitterName: String {
      switch self {
      case .register:
        return "CLIENT:REGISTER"
      case .consult_timeout:
        return "CLIENT:CONSULTATION_TIMEOUT"
      case .consultation_timeout:
        return "CLIENT:CONSULTATION_TIMEOUT"
      case .recall_lawyer:
        return "CLIENT:RECALL_LAWYER"
      case .choose_other_lawyer:
        return "CLIENT:CHOOSE_OTHER_LAWYER"
      }
    }
    
    
    
    func emit(params: [String : Any]) {
      SocketHelper.shared.socket.emit(emitterName, params)
    }
  }
  
  enum Listeners {
    
    case join_room
    case lawyer_reject_consultation
    case lawyer_is_recalled
    
    var listnerName: String {
      switch self {
      case .join_room:
        return "CLIENT:JOIN_ROOM"
      case .lawyer_reject_consultation:
        return "CLIENT:LAWYER_REJECT_CONSULTATION"
      case .lawyer_is_recalled:
        return "CLIENT:LAWYER_IS_RECALLED"
      }
    }
    
    func listen(completion: @escaping (Any) -> Void) {
      SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
        completion(response)
      }
    }
    
    func off() {
      SocketHelper.shared.socket.off(listnerName)
    }
  }
  
  func testEmitConnect() {
    let request: [String: Any] = [
      "param1": "1",
      "param2": "2",
      "param3": "3"
    ]
    
    socket.emit("TEST:CONNECTION_EMIT", request)
    
  }
  
  func testListenConnect() {
    socket.on("TEST:CONNECTION_ON") { data, ack in
      print("⚡️", data.first ?? "")
    }
  }
  
}
