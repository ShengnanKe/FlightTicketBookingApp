//
//  UserInfoViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userInfo: [String: Any] = [
        "First name": "",
        "Last name": "",
        "Email address": "",
        "Phone number": 0,
        "Passport": "",
        "Gender": true,
        "Date of birth": 0,
        "Name on card": "",
        "Debit/Credit card number": 0,
        "Expiration date": "",
        "Security code": 0,
        "Country/Territory": "",
        "Billing address": "",
        "City": "",
        "State": "",
        "Zipcode": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as? TextFieldTableViewCell
            let keys = ["First name", "Last name", "Email address", "Phone number", "Passport"]
            let key = keys[indexPath.row]
            cell?.formTextFieldLable.text = key
            cell?.formTextField.text = companyInfo[key] as? String ?? ""
            cell?.formTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
            cell?.formTextField.tag = indexPath.row
            return cell!
            
        }
    }
