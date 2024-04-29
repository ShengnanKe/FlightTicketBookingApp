//
//  DestinationSearchViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//
/*
 originCityPickerView / destinationCityPickerView
 departureDatePickerView / returnDatePickerView
 textfield: # of travelers
 save all userinput into the userBookingInfo dictionary and make people able to have access to edit delete and display on another view controller
 */

import UIKit

class DestinationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userBookingInfo: [String: Any] = [
        "Origin city": "",
        "Destination city": "",
        "Departure date": "",
        "Return date": "",
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
            print("Error loading cities from plist")
            return
        }
        cities = cityDictionary.keys.sorted()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 { // for the originCityPickerView/destinationCityPickerView and DepartureDatePickerView/returnDatePickerView
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
            return 120.0 // the date picker view takes more space
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
        else if indexPath.section == 1 { //DepartureDatePickerView / returnDatePickerView
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionsCell", for: indexPath) as? DateSelectionsTableViewCell
            switch indexPath.row {
            case 0:
                cell?.dateSelectionLabel.text = "Departure date"
                cell?.datePicker.tag = 0
            case 1:
                cell?.dateSelectionLabel.text = "return date"
                cell?.datePicker.tag = 1
            default:
                cell?.dateSelectionLabel.text = "Departure date"
                cell?.datePicker.tag = 0
            }
            return cell!
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
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all those info into the userBookingInfo dictionary
        saveBookingInfo()
        print(userBookingInfo)
    }
    
    func saveBookingInfo() {
        if let departureDateCell = myTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? DateSelectionsTableViewCell,
           let returnDateCell = myTableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? DateSelectionsTableViewCell,
           let travelersCell = myTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? TravelerNumTableViewCell,
           let originCity = (myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CitySelectionsTableViewCell)?.cityPickerView.accessibilityLabel,
           let destinationCity = (myTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CitySelectionsTableViewCell)?.cityPickerView.accessibilityLabel {
            
            let userBookingInfo = [
                "Origin city": originCity,
                "Destination city": destinationCity,
                "Departure date": departureDateCell.datePicker.date.timeIntervalSince1970,
                "Return date": returnDateCell.datePicker.date.timeIntervalSince1970,
                "Number of travelers": Int(travelersCell.travelerNumSlider.value)
            ] as [String : Any]
            
            UserDefaults.standard.set(userBookingInfo, forKey: "UserBookingInfo")
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
        if pickerView.tag == 0 {
            userBookingInfo["Origin city"] = selectedCity
        } else {
            userBookingInfo["Destination city"] = selectedCity
        }
    }
    
}



