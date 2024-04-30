//
//  BookingTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/26/24.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var originCityLabel: UILabel!
    @IBOutlet weak var destinationCityLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var selectedSeatsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
