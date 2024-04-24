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
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as?  UserInfoTextFieldTableViewCell
            let keys = ["First name", "Last name", "Email address", "Phone number", "Passport"]
            let key = keys[indexPath.row]
            cell?.formTextFieldLable.text = key
            cell?.formTextField.text = userInfo[key] as? String ?? ""
            cell?.formTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
            cell?.formTextField.tag = indexPath.row
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? UserInfoButtonTableViewCell
            cell?.submitButton.setTitle("Save", for: .normal)
            cell?.showUserInfoButton.setTitle("Show Company Info", for: .normal)
            return cell!
        }
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        guard let key = userInfoKey(for: sender.tag) else { return }
        userInfo[key] = sender.text ?? ""
    }
    
    private func userInfoKey(for tag: Int) -> String? {
        switch tag {
        case 0:
            return "First name";
        case 1:
            return  "Last name";
        case 2:
            return "Email address";
        case 3:
            return  "Phone number";
        case 4:
            return "Passport";
        case 5:
            return "Name on card";
        case 6:
            return "Expiration date";
        case 7:
            return "Country/Territory";
        default:
            return nil
        }
    }
    
}
