//
//  ChatCellTableViewCell.swift
//  chatku
//
//  Created by Anang Kurniawan on 26/11/24.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var avatarLabelLeft: UILabel!
    @IBOutlet weak var avatarViewLeft: UIView!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.layer.cornerRadius = avatarView.frame.height / 5
        chatView.layer.cornerRadius = chatView.frame.height / 5
        avatarViewLeft.layer.cornerRadius = avatarViewLeft.frame.height / 5
    }
    
    func updateContent(message: Message?, currentUser: String?) {
        if let safeMessage = message, let safeUser = currentUser {
            let user = safeMessage.user
            let avatarIndex = user.index(user.startIndex, offsetBy: 2)
            avatarLabel.text = user.substring(to: avatarIndex)
            avatarLabelLeft.text = user.substring(to: avatarIndex)
            messageLabel.text = safeMessage.message
            if safeUser == safeMessage.user {
                avatarViewLeft.isHidden = true
                avatarView.isHidden = false
                chatView.backgroundColor = .blue
                avatarView.backgroundColor = .blue
            } else {
                avatarViewLeft.isHidden = false
                avatarView.isHidden = true
                chatView.backgroundColor = .orange
                avatarViewLeft.backgroundColor = .orange
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
