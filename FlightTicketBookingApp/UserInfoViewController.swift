//
//  UserInfoViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userInfoTableView: UITableView!
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as?  UserInfoTextFieldTableViewCell
            switch indexPath.row {
            case 0:
                cell?.formTextFieldLable.text = "First name"// , "Email address", , "Passport"]
                cell?.formTextField.text = userInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 1:
                cell?.formTextFieldLable.text = "Last name"
                cell?.formTextField.text = userInfo["Last name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 2:
                cell?.formTextFieldLable.text = "Email address"
                cell?.formTextField.text = userInfo["Email address"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 3:
                cell?.formTextFieldLable.text = "Phone number"
                cell?.formTextField.text = userInfo["Phone number"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 4:
                cell?.formTextFieldLable.text = "Passport"
                cell?.formTextField.text = userInfo["Passport"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            default:
                cell?.formTextFieldLable.text = "First name"// , "Email address", "Phone number", "Passport"]
                cell?.formTextField.text = userInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            }
            return cell!
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserGenderCell", for: indexPath) as?  UserGenderTableViewCell
            cell?.genderSelectionLabel.text = "Gender"
            cell?.genderSelectionSegment.removeAllSegments()
            cell?.genderSelectionSegment.insertSegment(withTitle: "Male", at: 0, animated: false)
            cell?.genderSelectionSegment.insertSegment(withTitle: "Female", at: 1, animated: false)
            cell?.genderSelectionSegment.insertSegment(withTitle: "Other", at: 2, animated: false)
            
            // Set the selected segment based on user data
            if let gender = userInfo["Gender"] as? String {
                switch gender {
                case "Male":
                    cell?.genderSelectionSegment.selectedSegmentIndex = 0
                case "Female":
                    cell?.genderSelectionSegment.selectedSegmentIndex = 1
                case "Other":
                    cell?.genderSelectionSegment.selectedSegmentIndex = 2
                default:
                    cell?.genderSelectionSegment.selectedSegmentIndex = UISegmentedControl.noSegment
                }
            } else {
                cell?.genderSelectionSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            }
            
            cell?.genderSelectionSegment.addTarget(self, action: #selector(genderSegmentChanged(_:)), for: .valueChanged)
            
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? UserInfoButtonTableViewCell
            cell?.submitButton.setTitle("Save", for: .normal)
            //cell?.showUserInfoButton.setTitle("Show Company Info", for: .normal)
            return cell!
        }
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        guard let key = userInfoKey(for: sender.tag) else { return }
        userInfo[key] = sender.text ?? ""
    }
    
    @objc func genderSegmentChanged(_ sender: UISegmentedControl) {
        let gender: String
        switch sender.selectedSegmentIndex {
        case 0:
            gender = "Male"
        case 1:
            gender = "Female"
        case 2:
            gender = "Other"
        default:
            gender = "Unknown" 
        }
        // Update the userInfo dictionary
        userInfo["Gender"] = gender
        print("Gender updated to \(gender)")
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
