//
//  LawyerMessagingVC+ExtensionTableView.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 10/08/23.
//

import Foundation
import Foundation
import UIKit
import SocketIO
import CoreMedia
import SDWebImage

extension LawyerMessagingVC : UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.messages.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cellFix = UITableViewCell()
    if let message = self.messages[indexPath.row] as? MessagingReceiveListener {
      if message.user_name == vm.lawyerName { //this is value this profile client or lawyer*
        if message.file == nil {
          let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageFromMeTVCell.identifier, for: indexPath) as! ChatMessageFromMeTVCell
          cell.lblTimeMessageTVCell.text = DateFormatter.timeStampToStringDate(timestamp: message.sent_at ?? 0,to: .timeOnly)
          cell.lblValueMessageTVCell.text = message.message
          cell.lblValueCopyMessageTVCell.text = message.message
          cell.viewChatBackgroud.roundCorners(value: 15)
          cell.viewChatBackgroud.addShadow(cornerRadius: 15)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(withIdentifier: ChatAttachmentFromMeTVCell.identifier, for: indexPath) as! ChatAttachmentFromMeTVCell
          cell.imgChatAttachmentFromMeMsg.sd_setImage(with: URL(string: message.file?.url ?? ""), placeholderImage: UIImage(named: "img_placeholder"))
          cell.lblTimeChatAttachMessageFromMe.text = DateFormatter.timeStampToStringDate(timestamp: message.sent_at ?? 0,to: .timeOnly)
          cell.lblValueChatAttachMessageFromMe.text = message.message
          cell.lblValueCopyChatAttachMessageFromMe.text = message.message
          cell.viewChatAttachmentBackgroud.roundCorners(value: 15)
          cell.viewChatAttachmentBackgroud.addShadow(cornerRadius: 15)
          return cell
        }
      } else {
        if message.file == nil {
          let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageToMeTVCell.identifier, for: indexPath) as! ChatMessageToMeTVCell
          cell.lblTimeChatMessageToMe.text = DateFormatter.timeStampToStringDate(timestamp: message.sent_at ?? 0,to: .timeOnly)
          cell.lblValueChatMessageToMe.text = message.message
          cell.lblValueCopyChatMessageToMe.text = message.message
          cell.containerChatMessageToMe .roundCorners(value: 15)
          cell.containerChatMessageToMe.addShadow(cornerRadius: 15)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(withIdentifier: ChatAttachmentToMeTVCell.identifier, for: indexPath) as! ChatAttachmentToMeTVCell
          cell.imgChatAttachmentToMeMsg.sd_setImage(with: URL(string: message.file?.url ?? ""), placeholderImage: UIImage(named: "img_placeholder"))
          cell.lblTimeChatAttachmentToMe.text = DateFormatter.timeStampToStringDate(timestamp: message.sent_at ?? 0,to: .timeOnly)
          cell.lblValueChatAttachmentToMe.text = message.message
          cell.lblValueCopyChatAttachmentToMe.text = message.message
          cell.viewChatAttachmentToMeBackgroud.roundCorners(value: 15)
          cell.viewChatAttachmentToMeBackgroud.addShadow(cornerRadius: 15)
          return cell
        }
      }
    }
    return tableView.dequeueReusableCell(withIdentifier: "")!
  }
}
