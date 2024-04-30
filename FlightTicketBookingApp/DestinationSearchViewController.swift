//
//  DestinationSearchViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//
/*
 originCityPickerView / destinationCityPickerView
 departureDate textfield / returnDate textfield
 textfield: # of travelers
 save all userinput into the userBookingInfo dictionary and make people able to have access to edit delete and display on another view controller
 
 
 struct UserBookingInfo: Codable {
 var originCity: String
 var destinationCity: String
 var departureDate: String
 var returnDate: String
 var numberOfTravelers: Int
 }
 
 */

import UIKit

class DestinationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var bookingDetails["bookingInfo"] = [
        "Origin City": "",
        "Destination city": "",
        "Start date": "",
        "End date": "",
        "Number of travelers": 0
    ]
    
    @IBOutlet weak var myTableView: UITableView!
    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorColor = .clear
        
        // load city list from plist
        guard let plistPath = Bundle.main.path(forResource: "Cities", ofType: "plist"),
              let plistData = FileManager.default.contents(atPath: plistPath),
              let citiesData = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil),
              let cityDictionary = citiesData as? [String: String] else {
            print("Error!!! loading cities from plist")
            return
        }
        cities = cityDictionary.keys.sorted()
        
        if let loadedBookingInfo = loadBookingInfo() {
            bookingInfo = loadedBookingInfo
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 { // for the originCityPickerView/destinationCityPickerView and DepartureDate textfield /returnDate textfield
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230.0 // the city picker view takes more space
        } else if indexPath.section == 1{
            return 110.0 // the textfield takes more space -> swiched format
        }else {
            return 100.0 // The height for all other cells
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CitySelectionsCell", for: indexPath) as! CitySelectionsTableViewCell
            cell.cityPickerView.delegate = self
            cell.cityPickerView.dataSource = self
            if indexPath.row == 0 {
                cell.citySelectionLabel.text = "Origin City"
                cell.cityPickerView.tag = 0
            } else {
                cell.citySelectionLabel.text = "Destination City"
                cell.cityPickerView.tag = 1
            }
            cell.cityPickerView.reloadAllComponents()
            return cell
        }
        else if indexPath.section == 1 { // DepartureDate textfield / returnDate textfield
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionsCell", for: indexPath) as? DateSelectionsTableViewCell
            cell?.dateTextfield.delegate = self // for textfield delegate
            switch indexPath.row {
            case 0:
                cell?.dateSelectionLabel.text = "Departure date"
                cell?.dateTextfield.tag = 0
                cell?.dateTextfield.text = bookingInfo.departureDate
            case 1:
                cell?.dateSelectionLabel.text = "Return date"
                cell?.dateTextfield.tag = 1
                cell?.dateTextfield.text = bookingInfo.returnDate
            default:
                cell?.dateSelectionLabel.text = "Return date"
                cell?.dateTextfield.tag = 1
                cell?.dateTextfield.text = bookingInfo.returnDate
            }
            
            return cell ?? UITableViewCell()
        }
        else if indexPath.section == 2 { //textfield: # of travelers
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelerNumCell", for: indexPath) as? TravelerNumTableViewCell
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchButtonsCell", for: indexPath) as? SearchButtonTableViewCell
            cell?.searchButton.setTitle("Save and Select Seat(s)", for: .normal)
            return cell!
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 { // departure date
            bookingInfo.departureDate = textField.text ?? ""
            print("Departure date set to: \(textField.text ?? "invalid input")")
        } else if textField.tag == 1 { // return date
            bookingInfo.returnDate = textField.text ?? ""
            print("Return date set to: \(textField.text ?? "invalid input")")
        }
    }
    
    
    @IBAction func numberOfTravelersChanged(_ sender: UISlider) {
        bookingInfo.numberOfTravelers = Int(sender.value)
        print("Number of travelers set to: \(Int(sender.value))")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info-userBookingInfo struct
        
        view.endEditing(true) // needed cause the Return date wasn't saved properly
        saveBookingInfo()
        printCurrentBookingInfo()
        
    }
    
    func saveBookingInfo() {
    }
    
    func loadBookingInfo() -> UserBookingInfo? {
        return nil
    }
    
    
    // for checking if info has been saved or not
    func printCurrentBookingInfo() {
    }
    
}


extension DestinationSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = cities[row]
        if pickerView.tag == 0 {
            bookingInfo.originCity = selectedCity
            print("Origin city set to: \(selectedCity)")
        } else {
            bookingInfo.destinationCity = selectedCity
            print("Destination city set to: \(selectedCity)")
        }
    }
    
}




