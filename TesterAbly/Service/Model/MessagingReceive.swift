//
//  MessagingReceiveListener.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 03/08/23.
//

import Foundation

import Foundation

struct MessagingReceiveListener : Codable {
  var __v : Int?
  var _id : String?
  var consultation_id : Int?
  var user_name : String?
  var sender : String?
  var message :String?
  var file : FileReceiveListener? = FileReceiveListener(url: "", file_size: "", file_name: "", file_ext: "")
  var sent_at : Int?
  var delivered_at : Int?
  var read_at : Int?
}

struct FileReceiveListener : Codable {
  var url : String = ""
  var file_size : String = ""
  var file_name : String = ""
  var file_ext : String = ""
}


struct PresenceReceiveListener : Codable {
  var sender : String?
  var event : String?
}
