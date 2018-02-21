//
//  ChannelCellTableViewCell.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/19/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.3).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
    
    func configureCell (channel: Channel) {
        let title = channel.channel ?? ""
        channelNameLbl.text = "#\(title)"
        
    }
    
    

}
