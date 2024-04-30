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
    
    var bookingDetails: [String: Any] = [
        "bookingInfo": [
            "originCity": "",
            "destinationCity": "",
            "departureDate": Date(),
            "returnDate": Date(),
            "numberOfTravelers": 0
        ]
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
        else if indexPath.section == 1 { // DepartureDate datePicker / ReturnDate datePicker
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionsCell", for: indexPath) as? DateSelectionsTableViewCell else {
                return UITableViewCell() // Return an empty cell if the dequeued cell is not of the expected type
            }
            cell.datePicker.tag = indexPath.row // 0 for departure, 1 for return
            if indexPath.row == 0 {
                cell.datePicker.date = bookingDetails["departureDate"] as! Date
            } else {
                cell.datePicker.date = bookingDetails["returnDate"] as! Date
            }
            return cell
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
    
    @IBAction func numberOfTravelersChanged(_ sender: UISlider) {
        let numberOfTravelers = Int(sender.value)
        
        if var bookingInfo = bookingDetails["bookingInfo"] as? [String: Any] {
            bookingInfo["numberOfTravelers"] = numberOfTravelers
            bookingDetails["bookingInfo"] = bookingInfo  // Update the overall dictionary
        }
        print("Number of travelers set to: \(numberOfTravelers)")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info-userBookingInfo struct
        
        view.endEditing(true) // needed cause the Return date wasn't saved properly
        saveBookingInfo()
        printCurrentBookingInfo()
        
    }
    
    func saveBookingInfo() {
        let defaults = UserDefaults.standard
        defaults.set(bookingDetails, forKey: "bookingDetails")
        defaults.synchronize()
    }

    // for checking if info has been saved or not
    func printCurrentBookingInfo() {
        if let bookingInfo = bookingDetails["bookingInfo"] as? [String: Any] {
            print("Current Booking Info:", bookingInfo)
        }
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
        if var bookingInfo = bookingDetails["bookingInfo"] as? [String: Any] {
            if pickerView.tag == 0 {
                bookingInfo["originCity"] = selectedCity
                print("Origin city set to: \(selectedCity)")
            } else {
                bookingInfo["destinationCity"] = selectedCity
                print("Destination city set to: \(selectedCity)")
            }
            bookingDetails["bookingInfo"] = bookingInfo
        }
    }
    
}




