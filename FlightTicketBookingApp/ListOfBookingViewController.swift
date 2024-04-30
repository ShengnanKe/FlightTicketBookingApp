//
//  ListOfBookingViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/26/24.
//
/*
 i want to create an overall dictionary with every details of a booking in the with the initial VC - ListOfBookingViewController, and on the the next VC (DestinationSearchViewController) filling couple of values of the dictionary., and on the next VC, save seats info with SeatSelectionViewController, and finally with UserInfoViewController to save all the billing info and then save everything in userdefaults. and how should I set it up here
 
 */

import UIKit

class ListOfBookingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfBookingTableView: UITableView!
    @IBOutlet weak var listOfBookingLabel: UILabel!
    
    var bookings: [[String: Any]] = [] // this contains all the booking details from userdefaults
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //        print(docDirectoryURL)
        
        listOfBookingTableView.dataSource = self
        listOfBookingTableView.delegate = self
        // Do any additional setup after loading the view.
        
        bookings = loadBookings()
        listOfBookingTableView.reloadData()
        
        print("called printSavedBookings()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookings = loadBookings()
        listOfBookingTableView.reloadData()
        print("View will appear and bookings are reloaded.")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // one for the display
        // one for the add booking button
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // for booking list
            return bookings.count // depends on how many user booking i have saved
        }
        else {
            return 1 // for the 'Add a Booking' button cell
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as? BookingTableViewCell else {
                fatalError("The dequeued cell is not an instance of BookingTableViewCell.")
            }
            
            let bookingDict = bookings[indexPath.row]
            
            // Extract bookingInfo and billingInfo parts
            let bookingInfo = bookingDict["bookingInfo"] as? [String: Any] ?? [:]
            let billingInfo = bookingDict["billingInfo"] as? [String: Any] ?? [:]
            let selectedSeats = bookingDict["selectedSeats"] as? [String: Bool] ?? [:]
            
            // Set the labels in the cell
            cell.userNameLabel.text = "\(billingInfo["firstName"] as? String ?? "") \(billingInfo["lastName"] as? String ?? "")"
            cell.originCityLabel.text = "From: \(bookingInfo["originCity"] as? String ?? "N/A")"
            cell.destinationCityLabel.text = "To: \(bookingInfo["destinationCity"] as? String ?? "N/A")"
            
            // Formatting the dates
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            if let departureDate = bookingInfo["departureDate"] as? Date,
               let returnDate = bookingInfo["returnDate"] as? Date {
                cell.departureDateLabel.text = "Depart: \(dateFormatter.string(from: departureDate))"
                cell.returnDateLabel.text = "Return: \(dateFormatter.string(from: returnDate))"
            } else {
                cell.departureDateLabel.text = "Depart: N/A"
                cell.returnDateLabel.text = "Return: N/A"
            }
            
            // Handling selected seats display
            let selectedSeatKeys = selectedSeats.filter { $0.value }.map { $0.key }
            cell.selectedSeatsLabel.text = "Seats: \(selectedSeatKeys.joined(separator: ", "))"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBookingCell", for: indexPath) as? AddBookingButtonTableViewCell
            cell?.addBookingButton.setTitle("Add a Booking", for: .normal)
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard indexPath.section == 0 else { return nil } // only the bookings cell has delete and update
        
        // Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
            self?.bookings.remove(at: indexPath.row)
            self?.saveBookings()
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, view, completionHandler in
            // Assuming you have a method to handle editing
            self?.editBooking(at: indexPath.row)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
        
    func editBooking(at index: Int) {
        print("Edit booking at index \(index)")
    }
    
    @IBAction func addBookingButtonPressed(_ sender: UIButton) {
        // data for a new booking
        let newBooking: [String: Any] = [
            "bookingInfo": [
                "originCity": "",
                "destinationCity": "",
                "departureDate": Date(),
                "returnDate": Date(),
                "numberOfTravelers": 1
            ],
            "selectedSeats": [:],
            "billingInfo": [
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
        ]
        bookings.append(newBooking)
        saveBookings()
        listOfBookingTableView.reloadData()
    }

    func loadBookings() -> [[String: Any]] {
        let defaults = UserDefaults.standard
        if let savedBookings = defaults.array(forKey: "Bookings") as? [[String: Any]] {
            return savedBookings
        }
        return []  // Return an empty array if there are no saved bookings
    }
    
    func saveBookings() {
        let defaults = UserDefaults.standard
        defaults.set(bookings, forKey: "Bookings")
        defaults.synchronize()
    }
    
    
}
