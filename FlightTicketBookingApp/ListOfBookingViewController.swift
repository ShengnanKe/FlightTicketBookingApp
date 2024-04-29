//
//  ListOfBookingViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/26/24.
//

/*
 
 list of booking, a button -> add a booking () then navigate to the page for destination selection ->seat selection -> user info -> able to edit
 
 save data of seat data that seat is already been booked, it need to be gray out.  edit, free the ticket if the booking been deleted.
 
 */

import UIKit

class ListOfBookingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfBookingTableView: UITableView!
    @IBOutlet weak var listOfBookingLabel: UILabel!
    
    struct UserBillingInfo: Codable {
        var firstName: String
        var lastName: String
        var email: String
        // Add other billing properties...
    }

    struct UserBookingInfo: Codable {
        var originCity: String
        var destinationCity: String
        var departureDate: Date
        var returnDate: Date
        var numberOfTravelers: Int
    }

    struct Booking: Codable {
        var billingInfo: UserBillingInfo
        var bookingInfo: UserBookingInfo
        var selectedSeats: [String: Bool]
    }

    
    
    
    var users: [NSDictionary] = []
    
    func loadBookingInfo() {
        if let userBookingInfo = UserDefaults.standard.dictionary(forKey: "UserBookingInfo") {
            let originCity = userBookingInfo["Origin city"] as? String ?? ""
            let destinationCity = userBookingInfo["Destination city"] as? String ?? ""
            let departureDate = Date(timeIntervalSince1970: userBookingInfo["Departure date"] as? TimeInterval ?? 0)
            let returnDate = Date(timeIntervalSince1970: userBookingInfo["Return date"] as? TimeInterval ?? 0)
            let numberOfTravelers = userBookingInfo["Number of travelers"] as? Int ?? 0
        }
    }
    
    var userBillingInfo: [String: Any] = [:]
    
    func loadUserBillingInfo() {
        if let loadedBillingInfo = UserDefaults.standard.dictionary(forKey: "UserBillingInfo") {
            userBillingInfo = loadedBillingInfo
            
            // Optionally update the UI with this information
            // updateUIWithLoadedInfo()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // for booking list
            return users.count // depends on how many user booking i have saved
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as? BookingTableViewCell else {
                fatalError("The dequeued cell is not an instance of CompanyTableViewCell.")
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBookingCell", for: indexPath) as? AddBookingButtonTableViewCell
            cell?.addBookingButton.setTitle("Add a Booking", for: .normal)
            return cell!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfBookingTableView.dataSource = self
        listOfBookingTableView.delegate = self
        listOfBookingTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (_, _, completionHandler) in
            
            self.users.remove(at: indexPath.row)
            self.saveUsers()
            self.listOfBookingTableView.reloadData()
            completionHandler(true)
        })
        
        
        let updateAction = UIContextualAction(style: .normal, title: "Update", handler: { (_, _, completionHandler) in completionHandler(true)
        })
        
        deleteAction.backgroundColor = .red
        updateAction.backgroundColor = .green
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    func fetchUsers() -> [NSDictionary] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "Users"),
           let users = try? JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
            return users
        }
        return []
    }
    
    func saveUsers() {
        let defaults = UserDefaults.standard
        if let data = try? JSONSerialization.data(withJSONObject: users, options: []) {
            defaults.set(data, forKey: "Users")
        }
    }
    
}
