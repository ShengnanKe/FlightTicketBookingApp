//
//  UserGenderTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

import UIKit

class UserGenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var genderSelectionLabel: UILabel!
    @IBOutlet weak var genderSelectionSegment: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
