//
//  MessageCellTableViewCell.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/24/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        guard let avatar = message.userAvatar else { return }
        guard let avatarColor = message.userAvatarColor else { return }
        userImg.image = UIImage(named: avatar)
        userImg.backgroundColor = UserDataService.instance.returnColor(colorString: avatarColor)
        userNameLbl.text = message.userName
        messageLbl.text = message.messageBody

    }
    
    

}
