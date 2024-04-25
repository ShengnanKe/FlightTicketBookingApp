//
//  TravelerNumTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

import UIKit

class TravelerNumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var travelerNumTextLable: UILabel!
    @IBOutlet weak var travelerNumTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
