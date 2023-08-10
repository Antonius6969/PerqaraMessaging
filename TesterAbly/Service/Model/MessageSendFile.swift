//
//  MessageSendFile.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation

struct MessageSendFile : Codable {
  var authorized_token: String = ""
  var room_key: String = ""
  var message: String = ""
  var file: Data
  var send_time: String = ""
}
