//
//  ChatCellTableViewCell.swift
//  chatku
//
//  Created by Anang Kurniawan on 26/11/24.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var emailLabelLeft: UILabel!
    @IBOutlet weak var avatarLabelLeft: UILabel!
    @IBOutlet weak var messageLabelLeft: UILabel!
    @IBOutlet weak var avatarViewLeft: UIView!
    @IBOutlet weak var chatViewLeft: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.layer.cornerRadius = avatarView.frame.height / 5
        chatView.layer.cornerRadius = chatView.frame.height / 5
        
        avatarViewLeft.layer.cornerRadius = avatarViewLeft.frame.height / 5
        chatViewLeft.layer.cornerRadius = chatViewLeft.frame.height / 5
        
        avatarView.backgroundColor = .orange
        chatView.backgroundColor = .blue
        
        avatarViewLeft.backgroundColor = .blue
        chatViewLeft.backgroundColor = .orange
    }
    
    func updateContent(message: Message?, currentUser: String?) {
        if let safeMessage = message, let safeUser = currentUser {
            let avatarString = provideAvatarString(user: safeMessage.user)
            setDataViewLeft(user: safeMessage.user, avatar: avatarString, message: safeMessage.message)
            setDataViewRight(user: safeMessage.user, avatar: avatarString, message: safeMessage.message)
            if safeUser == safeMessage.user {
                hideViewLeft(isHidden: true)
                hideViewRight(isHidden: false)
            } else {
                hideViewLeft(isHidden: false)
                hideViewRight(isHidden: true)
            }
        }
    }
    
    private func provideAvatarString(user: String) -> String {
        return user.substring(to: user.index(user.startIndex, offsetBy: 2))
    }
    
    private func setDataViewLeft(user: String, avatar: String, message: String) {
        emailLabelLeft.text = user
        avatarLabelLeft.text = avatar
        messageLabelLeft.text = message
    }
    
    private func setDataViewRight(user: String, avatar: String, message: String) {
        emailLabel.text = user
        avatarLabel.text = avatar
        messageLabel.text = message
    }
    
    private func hideViewLeft(isHidden: Bool) {
        avatarViewLeft.isHidden = isHidden
        chatViewLeft.isHidden = isHidden
        emailLabelLeft.isHidden = isHidden
    }
    
    private func hideViewRight(isHidden: Bool) {
        avatarView.isHidden = isHidden
        chatView.isHidden = isHidden
        emailLabel.isHidden = isHidden
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
