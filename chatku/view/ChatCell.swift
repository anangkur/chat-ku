//
//  ChatCellTableViewCell.swift
//  chatku
//
//  Created by Anang Kurniawan on 26/11/24.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.layer.cornerRadius = avatarView.frame.height / 5
        chatView.layer.cornerRadius = chatView.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
