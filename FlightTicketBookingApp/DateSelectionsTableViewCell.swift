//
//  DateSelectionsTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
// startDatePickerView / endDatePickerView

import UIKit

class DateSelectionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateSelectionLabel: UILabel!
    @IBOutlet weak var dateTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //datePicker.datePickerMode = .date // .dateAndTime
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
