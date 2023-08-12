//
//  ChatMessageFromMeTVCell.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 08/03/23.
//

import UIKit
import Foundation

class ChatMessageFromMeTVCell: UITableViewCell {
    
    
    @IBOutlet weak var lblValueCopyMessageTVCell: UILabel!
    @IBOutlet weak var viewChatBackgroud: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var lblTimeMessageTVCell: UILabel!
    @IBOutlet weak var lblValueMessageTVCell: UILabel!
    
    static let identifier = "ChatMessageFromMeTVCellIdentifier"
    static let nibName = "ChatMessageFromMeTVCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(payload : MessagingReceiveListener){
        lblValueMessageTVCell.text = payload.message
        lblTimeMessageTVCell.text = "\(payload.sent_at)"
        viewChatBackgroud.roundCorners(value: 30
        )
    }
}
