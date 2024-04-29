//
//  UserInfoViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

// show a list of booking
// delete and update

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userInfoTableView: UITableView!
    
    var userBillingInfo: [String: Any] = [
        "First name": "",
        "Last name": "",
        "Email address": "",
        "Phone number": "",
        "Passport": "",
        "Gender": "",
        "Date of birth": "",
        "Name on card": "",
        "Debit/Credit card number": "",
        "Expiration date": "",
        "Security code": "",
        "Country/Territory": "",
        "Billing address": "",
        "City": "",
        "State": "",
        "Zipcode": ""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 16
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as?  UserInfoTextFieldTableViewCell
            switch indexPath.row {
            case 0:
                cell?.formTextFieldLable.text = "First name"
                cell?.formTextField.text = userBillingInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 1:
                cell?.formTextFieldLable.text = "Last name"
                cell?.formTextField.text = userBillingInfo["Last name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 2:
                cell?.formTextFieldLable.text = "Email address"
                cell?.formTextField.text = userBillingInfo["Email address"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 3:
                cell?.formTextFieldLable.text = "Phone number"
                cell?.formTextField.text = userBillingInfo["Phone number"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 4:
                cell?.formTextFieldLable.text = "Passport"
                cell?.formTextField.text = userBillingInfo["Passport"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 5:
                cell?.formTextFieldLable.text = "Gender"
                cell?.formTextField.text = userBillingInfo["Gender"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 6:
                cell?.formTextFieldLable.text = "Date of birth"
                cell?.formTextField.text = userBillingInfo["Date of birth"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 7:
                cell?.formTextFieldLable.text =  "Name on card"
                cell?.formTextField.text = userBillingInfo[ "Name on card"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 8:
                cell?.formTextFieldLable.text = "Debit/Credit card number"
                cell?.formTextField.text = userBillingInfo["Debit/Credit card number"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 9:
                cell?.formTextFieldLable.text = "Expiration date"
                cell?.formTextField.text = userBillingInfo["Expiration date"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 10:
                cell?.formTextFieldLable.text = "Security code"
                cell?.formTextField.text = userBillingInfo["Security code"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 11:
                cell?.formTextFieldLable.text = "Country/Territory"
                cell?.formTextField.text = userBillingInfo["Country/Territory"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 12:
                cell?.formTextFieldLable.text = "Billing address"
                cell?.formTextField.text = userBillingInfo["Billing address"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 13:
                cell?.formTextFieldLable.text = "City"
                cell?.formTextField.text = userBillingInfo["City"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 14:
                cell?.formTextFieldLable.text = "State"
                cell?.formTextField.text = userBillingInfo["State"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            case 15:
                cell?.formTextFieldLable.text = "Zipcode"
                cell?.formTextField.text = userBillingInfo["Zipcode"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            default:
                cell?.formTextFieldLable.text = "First name"
                cell?.formTextField.text = userBillingInfo["First name"] as? String ?? ""
                cell?.formTextField.tag = indexPath.row
            }
            return cell!
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? UserInfoButtonTableViewCell else {
                fatalError("The dequeued cell is not an instance of UserInfoButtonTableViewCell.")
            }
            cell.submitButton.setTitle("Save User Billing Info", for: .normal)
            // navigate to the list of bookings
            return cell
            
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info into the userBookingInfo dictionary
        saveUserBillingInfo()
        print(userBillingInfo)
    }
    
    func saveUserBillingInfo() {
        for (index, key) in userBillingInfo.keys.enumerated() {
            if let cell = userInfoTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UserInfoTextFieldTableViewCell {
                userBillingInfo[key] = cell.formTextField.text
            }
        }
        UserDefaults.standard.set(userBillingInfo, forKey: "UserBillingInfo")
    }
    
    
}
