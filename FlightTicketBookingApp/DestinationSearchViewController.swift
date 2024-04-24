//
//  DestinationSearchViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class DestinationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    datePicker.datePickerMode = .date // or .time / .dateAndTime
    datePicker.minimumDate = Date() // current date
    if let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: Date()) {
        // set up the range from current date to one year later
        datePicker.maximumDate = oneYearFromNow
    }
        
        
        
        var selectedOriginCity: String?
        var selectedDestinationCity: String?
        
        
        var citiesList: [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.separatorColor = .clear
            
            // Do any additional setup after loading the view.
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return 2
            }
            else {
                return 1
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 250.0 // the picker view takes more space
            } else if indexPath.section == 1{
                return 200.0 // the picker view takes more space
            }else {
                return 100.0 // The height for all other cells
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as? TextFieldTableViewCell
                let keys = ["Company Name", "Head Office Address", "Website"]
            }
            
        }
        }
