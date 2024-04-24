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
    
    @IBOutlet weak var myTableView: UITableView!
    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorColor = .clear
        // Do any additional setup after loading the view.
        loadCitiesFromPlist()
    }
    
    func loadCitiesFromPlist() {
        if let path = Bundle.main.path(forResource: "Cities", ofType: "plist"),
           let cityArray = NSArray(contentsOfFile: path) as? [String] {
            cities = cityArray
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
            return 250.0 // the city picker view takes more space
        } else if indexPath.section == 1{
            return 200.0 // the date picker view takes more space
        }else {
            return 100.0 // The height for all other cells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityPickerCell", for: indexPath) as? CitySelectionsTableViewCell else {
                    fatalError("The dequeued cell is not an instance of CitySelectionsTableViewCell.")
                }
                // Assuming you have the PickerMode enum inside the CitySelectionsTableViewCell
                // The following is pseudocode for illustration, replace with actual implementation.
                cell.pickerMode = indexPath.row == 0 ? .origin : .destination // Set the mode based on the row
                // Rest of the cell configuration...
                return cell
            }
        
    }
}
