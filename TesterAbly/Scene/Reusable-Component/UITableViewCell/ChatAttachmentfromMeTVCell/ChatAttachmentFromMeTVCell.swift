//
//  ChatAttachmentFromMeTVCell.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 08/03/23.
//

import UIKit

class ChatAttachmentFromMeTVCell: UITableViewCell {
  
  
  @IBOutlet weak var imgChatAttachmentFromMeMsg: UIImageView!
  @IBOutlet weak var lblValueCopyChatAttachMessageFromMe: UILabel!
  @IBOutlet weak var containerChatAttachMessageFromMe: UIView!
  @IBOutlet weak var lblValueChatAttachMessageFromMe: UILabel!
  @IBOutlet weak var lblTimeChatAttachMessageFromMe: UILabel!
  @IBOutlet weak var viewChatAttachmentBackgroud: UIView!
  
  
  static let identifier = "ChatAttachmentFromMeTVCellIdentifier"
  static let nibName = "ChatAttachmentFromMeTVCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setupView(payload : MessagingReceiveListener){
    containerChatAttachMessageFromMe.roundCorners(value: 30)
    lblValueChatAttachMessageFromMe.text = payload.message
    lblValueCopyChatAttachMessageFromMe.text = payload.message
    lblTimeChatAttachMessageFromMe.text = "\(payload.sent_at)"
  }
}
