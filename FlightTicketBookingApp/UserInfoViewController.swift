//
//  UserInfoViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

// show a list of booking
// delete and update

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var userInfoTableView: UITableView!
    
    var userBillingInfo: [String: Any] = [
        "firstName": "",
        "lastName": "",
        "email": "",
        "phoneNumber": "",
        "passportNumber": "",
        "gender": "",
        "dateOfBirth": "",
        "cardName": "",
        "cardNumber": "",
        "expirationDate": "",
        "securityCode": "",
        "country": "",
        "billingAddress": "",
        "city": "",
        "state": "",
        "zipcode": ""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // textfields and for the button
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as! UserInfoTextFieldTableViewCell
            let field = Array(userBillingInfo.keys.sorted())[indexPath.row]
            cell.formTextFieldLabel.text = field.localizedCapitalized
            cell.formTextField.text = userBillingInfo[field] as? String ?? ""
            cell.formTextField.delegate = self
            cell.formTextField.tag = indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as! UserInfoButtonTableViewCell
            cell.submitButton.setTitle("Save User Billing Info", for: .normal)
            return cell
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let field = Array(userBillingInfo.keys.sorted())[textField.tag]
        userBillingInfo[field] = textField.text ?? ""
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info into the userBookingInfo dictionary
        view.endEditing(true) // for the same reason: the zipcode? always not saved properly.
        
        saveUserBillingInfo()
        
    }
    
    func saveUserBillingInfo() {
        UserDefaults.standard.set(userBillingInfo, forKey: "UserBillingInfo")
        UserDefaults.standard.synchronize()  // Ensure UserDefaults is immediately updated
        print("User billing info saved.")
    }
    
    func loadUserBillingInfo() {
        if let loadedInfo = UserDefaults.standard.dictionary(forKey: "UserBillingInfo") {
            userBillingInfo = loadedInfo
        }
    }
}
