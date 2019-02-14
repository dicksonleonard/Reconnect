//
//  HomeContactCell.swift
//  Reconnect
//
//  Created by Yolanda Halim on 12/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeContactCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
