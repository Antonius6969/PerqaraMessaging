//
//  ChatAttachmentToMeTVCell.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 08/03/23.
//

import UIKit

class ChatAttachmentToMeTVCell: UITableViewCell {
  
  
  @IBOutlet weak var imgChatAttachmentToMeMsg: UIImageView!
  @IBOutlet weak var lblValueCopyChatMessageToMe: UILabel!
  @IBOutlet weak var containerChatMessageToMe: UIView!
  @IBOutlet weak var lblValueChatMessageToMe: UILabel!
  @IBOutlet weak var lblTimeChatMessageToMe: UILabel!
  @IBOutlet weak var viewChatAttachmentToMeBackgroud: UIView!
  
  static let identifier = "ChatMessageToMeTVCelllIdentifier"
  static let nibName = "ChatMessageToMeTVCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setupView(payload : MessagingReceiveListener){
    containerChatMessageToMe.roundCorners(value: 30)
    lblValueChatMessageToMe.text = payload.message
    lblValueCopyChatMessageToMe.text = payload.message
    lblTimeChatMessageToMe.text = payload.sent_at
  }
}
