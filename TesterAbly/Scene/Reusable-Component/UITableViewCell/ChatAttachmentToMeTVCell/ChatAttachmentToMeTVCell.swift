//
//  ChatAttachmentToMeTVCell.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 08/03/23.
//

import UIKit

class ChatAttachmentToMeTVCell: UITableViewCell {
  
  
  @IBOutlet weak var imgChatAttachmentToMeMsg: UIImageView!
  @IBOutlet weak var lblValueCopyChatAttachmentToMe: UILabel!
  @IBOutlet weak var containerChatAttachmentToMe: UIView!
  @IBOutlet weak var lblValueChatAttachmentToMe: UILabel!
  @IBOutlet weak var lblTimeChatAttachmentToMe: UILabel!
  @IBOutlet weak var viewChatAttachmentToMeBackgroud: UIView!
  
  static let identifier = "ChatAttachmentToMeTVCellIdentifier"
  static let nibName = "ChatAttachmentToMeTVCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setupView(payload : MessagingReceiveListener){
    containerChatAttachmentToMe.roundCorners(value: 30)
    lblValueChatAttachmentToMe.text = payload.message
    lblValueCopyChatAttachmentToMe.text = payload.message
    lblTimeChatAttachmentToMe.text = "\(payload.sent_at)"
  }
}
