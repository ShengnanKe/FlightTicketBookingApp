//
//  UserInfoTextFieldTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class UserInfoTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formTextFieldLabel: UILabel!
    @IBOutlet weak var formTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var onTextChanged: ((String?) -> Void)?
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        onTextChanged?(sender.text)
    }

}
