//
//  ChannelCell.swift
//  BeOn
//
//  Created by sHiKoOo on 2/16/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(channel: ChannelData) {
        let title = channel.channelName 
        channelName.text = title
    }

}
