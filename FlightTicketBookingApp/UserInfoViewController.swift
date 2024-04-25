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
        "Gender": "",
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
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else if section == 2{
            return 9
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as?  UserInfoTextFieldTableViewCell
            switch indexPath.row {
            case 0:
                cell?.formTextFieldLable.text = "First name"
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
                cell?.formTextFieldLable.text = "First name"
                cell?.formTextField.text = userInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            }
            return cell!
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userGenderCell", for: indexPath) as?  UserGenderTableViewCell
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
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userBillingInfoTextFieldCell", for: indexPath) as?  UserBillingInfoTableViewCell
            switch indexPath.row {
            case 0:
                cell?.formTextFieldLable.text = "Date of birth"
                cell?.formTextField.text = userInfo["Date of birth"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 1:
                cell?.formTextFieldLable.text =  "Name on card"
                cell?.formTextField.text = userInfo[ "Name on card"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 2:
                cell?.formTextFieldLable.text = "Debit/Credit card number"
                cell?.formTextField.text = userInfo["Debit/Credit card number"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 3:
                cell?.formTextFieldLable.text = "Expiration date"
                cell?.formTextField.text = userInfo["Expiration date"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 4:
                cell?.formTextFieldLable.text = "Security code"
                cell?.formTextField.text = userInfo["Security code"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 5:
                cell?.formTextFieldLable.text = "Country/Territory"
                cell?.formTextField.text = userInfo["Country/Territory"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 6:
                cell?.formTextFieldLable.text = "Billing address"
                cell?.formTextField.text = userInfo["Billing address"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 7:
                cell?.formTextFieldLable.text = "City"
                cell?.formTextField.text = userInfo["City"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 8:
                cell?.formTextFieldLable.text = "State"
                cell?.formTextField.text = userInfo["State"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 9:
                cell?.formTextFieldLable.text = "Zipcode"
                cell?.formTextField.text = userInfo["Zipcode"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            default:
                cell?.formTextFieldLable.text = "First name"
                cell?.formTextField.text = userInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            }
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
