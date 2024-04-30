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
    
    var bookingDictionary: [String: Any] = [
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTextFieldCell", for: indexPath) as? UserInfoTextFieldTableViewCell else {
                fatalError("The dequeued cell is not an instance of UserInfoTextFieldTableViewCell.")
            }
            switch indexPath.row {
            case 0:
                cell.formTextFieldLabel.text = "First name"
                cell.formTextField.text = userBillingInfo.firstName
            case 1:
                cell.formTextFieldLabel.text = "Last name"
                cell.formTextField.text = userBillingInfo.lastName
            case 2:
                cell.formTextFieldLabel.text = "Email address"
                cell.formTextField.text = userBillingInfo.email
            case 3:
                cell.formTextFieldLabel.text = "Phone number"
                cell.formTextField.text = userBillingInfo.phoneNumber
            case 4:
                cell.formTextFieldLabel.text = "Passport"
                cell.formTextField.text = userBillingInfo.passportNumber
            case 5:
                cell.formTextFieldLabel.text = "Gender"
                cell.formTextField.text = userBillingInfo.gender
            case 6:
                cell.formTextFieldLabel.text = "Date of birth"
                cell.formTextField.text = userBillingInfo.dateOfBirth
            case 7:
                cell.formTextFieldLabel.text = "Name on card"
                cell.formTextField.text = userBillingInfo.cardName
            case 8:
                cell.formTextFieldLabel.text = "Debit/Credit card number"
                cell.formTextField.text = userBillingInfo.cardNumber
            case 9:
                cell.formTextFieldLabel.text = "Expiration date"
                cell.formTextField.text = userBillingInfo.expirationDate
            case 10:
                cell.formTextFieldLabel.text = "Security code"
                cell.formTextField.text = userBillingInfo.securityCode
            case 11:
                cell.formTextFieldLabel.text = "Country/Territory"
                cell.formTextField.text = userBillingInfo.country
            case 12:
                cell.formTextFieldLabel.text = "Billing address"
                cell.formTextField.text = userBillingInfo.billingAddress
            case 13:
                cell.formTextFieldLabel.text = "City"
                cell.formTextField.text = userBillingInfo.city
            case 14:
                cell.formTextFieldLabel.text = "State"
                cell.formTextField.text = userBillingInfo.state
            case 15:
                cell.formTextFieldLabel.text = "Zipcode"
                cell.formTextField.text = userBillingInfo.zipcode  // keyboard -> phone keyboard -> return
            default:
                break
            }
            cell.formTextField.delegate = self
            cell.formTextField.tag = indexPath.row
            
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? UserInfoButtonTableViewCell else {
                fatalError("The dequeued cell is not an instance of UserInfoButtonTableViewCell.")
            }
            cell.submitButton.setTitle("Save User Billing Info", for: .normal)
            // navigate back to the list of bookings -> set up in story board
            return cell
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            userBillingInfo.firstName = textField.text ?? ""
        case 1:
            userBillingInfo.lastName = textField.text ?? ""
        case 2:
            userBillingInfo.email = textField.text ?? ""
        case 3:
            userBillingInfo.phoneNumber = textField.text ?? ""
        case 4:
            userBillingInfo.passportNumber = textField.text ?? ""
        case 5:
            userBillingInfo.gender = textField.text ?? ""
        case 6:
            userBillingInfo.dateOfBirth = textField.text ?? ""
        case 7:
            userBillingInfo.cardName = textField.text ?? ""
        case 8:
            userBillingInfo.cardNumber = textField.text ?? ""
        case 9:
            userBillingInfo.expirationDate = textField.text ?? ""
        case 10:
            userBillingInfo.securityCode = textField.text ?? ""
        case 11:
            userBillingInfo.country = textField.text ?? ""
        case 12:
            userBillingInfo.billingAddress = textField.text ?? ""
        case 13:
            userBillingInfo.city = textField.text ?? ""
        case 14:
            userBillingInfo.state = textField.text ?? ""
        case 15:
            userBillingInfo.zipcode = textField.text ?? "" // zipcode is not being saved properly, when i redo it it's saved
        default:
            break
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info into the userBookingInfo dictionary
        view.endEditing(true) // for the same reason: the zipcode? always not saved properly.
        
        saveUserBillingInfo()
        
    }
    
    func saveUserBillingInfo() {
        
        var bookingInfo: UserBookingInfo?
        var selectedSeats: [String: Bool]?
        
        // Print out and see if BookingInfoData is being stored in the userdefaults
        if let bookingInfoData = UserDefaults.standard.data(forKey: "BookingInfo") {
            // print("BookingInfoData: \(bookingInfoData)")
            do {
                let bookingInfo = try JSONDecoder().decode(UserBookingInfo.self, from: bookingInfoData)
                print("BookingInfoData: \(bookingInfoData)")
            } catch {
                print("decode booking info failed!!! \(error)")
            }
        } else {
            print("BookingInfo -> data not found in UserDefaults.")
        }
        
        // check for selected seats
        if let selectedSeatsData = UserDefaults.standard.data(forKey: "SelectedSeats") { // not "SeatsAvailability"
            do {
                selectedSeats = try JSONDecoder().decode([String: Bool].self, from: selectedSeatsData)
                print("SelectedSeatsData: \(selectedSeatsData)")
            } catch {
                print("Failed to decode selected seats: \(error)")
            }
        } else {
            print("SelectedSeats data not found in UserDefaults.")
        }
        
        // finally the combination
        if let bookingInfo = bookingInfo, let selectedSeats = selectedSeats {
            let newBooking = Booking(billingInfo: userBillingInfo, bookingInfo: bookingInfo, selectedSeats: selectedSeats)
            var bookings = loadBookings()
            bookings.append(newBooking)
            saveBookings(bookings)
            print("save New booking")
        } else {
            print("Cannot save New booking")
        }
        
    }
    
    func loadBookings() -> [Booking] {
        return []
    }
    
    func saveBookings(_ bookings: [Booking]) {
        print("start saving booking info")
    }
}

