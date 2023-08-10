//
//  PresenceChatMessageTVCell.swift
//  Perqara - Clients
//
//  Created by antonius krisna sahadewa on 08/03/23.
//

import UIKit

class PresenceChatMessageTVCell: UITableViewCell {
    
    @IBOutlet weak var containerPresenceChatTVCell: UIView!
    @IBOutlet weak var lblPresenceChatTVCell: UILabel!
    
    static let identifier = "PresenceChatMessageTVCellIdentifier"
    static let nibName = "PresenceChatMessageTVCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
