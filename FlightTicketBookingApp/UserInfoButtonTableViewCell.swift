//
//  UserInfoButtonTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class UserInfoButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var showUserInfoButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
