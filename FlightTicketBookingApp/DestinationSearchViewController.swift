//
//  DestinationSearchViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//
/*
 originCityPickerView / destinationCityPickerView
 startDatePickerView / endDatePickerView
 textfield: # of travelers
 */

import UIKit

class DestinationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userInfo: [String: Any] = [
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
        
        loadCitiesFromPlist()
    }
    
    func loadCitiesFromPlist() {
        if let path = Bundle.main.path(forResource: "Cities", ofType: "plist"),
           let cityDictionary = NSDictionary(contentsOfFile: path) as? [String: String] {
            cities = Array(cityDictionary.keys).sorted()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 { // for the originCityPickerView/destinationCityPickerView and startDatePickerView/endDatePickerView
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
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        if let cell = sender.superview?.superview as? TravelerNumTableViewCell {
            let newValue = Int(sender.value)
            cell.travelerNumDisplayLabel.text = "Number of travelers - \(newValue)"
            userInfo["Number of travelers"] = newValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CitySelectionsCell", for: indexPath) as? CitySelectionsTableViewCell
            cell?.cityPickerView.delegate = self
            cell?.cityPickerView.dataSource = self
            switch indexPath.row {
            case 0:
                cell?.citySelectionLabel.text = "Origin City"
                cell?.pickerMode = .origin
                //cell?.cityPickerView.reloadAllComponents()
            case 1:
                cell?.citySelectionLabel.text = "Destination city"
                cell?.pickerMode = .destination
                //cell?.cityPickerView.reloadAllComponents()
            default:
                cell?.citySelectionLabel.text = "Origin city"
                //cell?.cityPickerView.reloadAllComponents()
            }
            cell?.cityPickerView.reloadAllComponents()
            return cell!
        }
        else if indexPath.section == 1 { //startDatePickerView / endDatePickerView
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionsCell", for: indexPath) as? DateSelectionsTableViewCell
            switch indexPath.row {
            case 0:
                cell?.dateSelectionLabel.text = "Start date"
                cell?.datePicker.tag = 0
            case 1:
                cell?.dateSelectionLabel.text = "End date"
                cell?.datePicker.tag = 1
            default:
                cell?.dateSelectionLabel.text = "Start date"
                cell?.datePicker.tag = 0
            }
            return cell!
        }
        else if indexPath.section == 2 {//textfield: # of travelers
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelerNumCell", for: indexPath) as? TravelerNumTableViewCell
            cell?.travelerNumTextLable.text = "Number of travelers" //travelerNumSlider
            cell?.travelerNumSlider.value = 1 // defalut as 1
            cell?.travelerNumSlider.minimumValue = 1
            cell?.travelerNumSlider.maximumValue = 25
            
            cell?.travelerNumSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchButtonsCell", for: indexPath) as? SearchButtonTableViewCell
            cell?.searchButton.setTitle("Search", for: .normal)
            return cell!
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
}



