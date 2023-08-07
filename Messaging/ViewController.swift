//
//  ViewController.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 22/05/23.
//

import UIKit
import Ably

class ViewController: UIViewController {
  
  fileprivate var chatMsgModel: ChatModel!
  var roomkey: String = ""
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.chatMsgModel = ChatModel(clientId: "dio")
    self.chatMsgModel.delegate = self
    self.chatMsgModel.connect(roomkey: self.roomkey)
  }


}

extension ViewController : ChatModelDelegate {
  func chatModel(_ chatModel: ChatModel, connectionStateChanged: ARTConnectionStateChange) {
  }
  
  func chatModelLoadingHistory(_ chatModel: ChatModel) {
    print("")
  }
  
  func chatModelDidFinishSendingMessage(_ chatModel: ChatModel) {
    print("")
  }
  
  func chatModel(_ chatModel: ChatModel, didReceiveMessage message: ARTMessage) {
    print("")
  }
  
  func chatModel(_ chatModel: ChatModel, didReceiveError error: ARTErrorInfo) {
  }
  
  func chatModel(_ chatModel: ChatModel, historyDidLoadWithMessages: [ARTBaseMessage]) {
    print("")
  }
  
  func chatModel(_ chatModel: ChatModel, membersDidUpdate: [ARTPresenceMessage], presenceMessage: ARTPresenceMessage) {
    print("")
  }
}

