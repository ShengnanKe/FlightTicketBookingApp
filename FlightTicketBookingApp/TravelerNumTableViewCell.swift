//
//  TravelerNumTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

import UIKit

class TravelerNumTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var travelerNumTextLable: UILabel!
    @IBOutlet weak var travelerNumSlider: UISlider!
    @IBOutlet weak var travelerNumDisplayLabel: UILabel!

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        travelerNumDisplayLabel.text = "Number of travelers - \(currentValue)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        travelerNumSlider.minimumValue = 1
        travelerNumSlider.maximumValue = 25
        travelerNumSlider.value = 1
        sliderValueChanged(travelerNumSlider)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
