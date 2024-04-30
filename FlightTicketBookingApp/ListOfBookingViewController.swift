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

//import UIKit

class ListOfBookingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfBookingTableView: UITableView!
    @IBOutlet weak var listOfBookingLabel: UILabel!
    
    var bookingDetails: [String: Any] = [:]
    
//    var bookingDictionary: [String: Any] = [
//        "bookingInfo": [
//            "Origin City": "",
//            "Destination city": "",
//            "Start date": "",
//            "End date": "",
//            "Number of travelers": 0
//        ],
//        "billingInfo": [
//            "First name": "",
//            "Last name": "",
//            "Email address": "",
//            "Phone number": 0,
//            "Passport": "",
//            "Gender": "",
//            "Date of birth": 0,
//            "Name on card": "",
//            "Debit/Credit card number": 0,
//            "Expiration date": "",
//            "Security code": 0,
//            "Country/Territory": "",
//            "Billing address": "",
//            "City": "",
//            "State": "",
//            "Zipcode": 0
//        ]
        // in need to think about this
//            ,
//        "selectedSeats": [ // [String: Bool]
//            "1A": true,
//            "1B": false
//        ]
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        print(docDirectoryURL)
        
        listOfBookingTableView.dataSource = self
        listOfBookingTableView.delegate = self
        listOfBookingTableView.reloadData()
        // Do any additional setup after loading the view.
        
        bookings = loadBookings()
        listOfBookingTableView.reloadData()
        
        printSavedBookings()
        print("called printSavedBookings()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookings = loadBookings()
        listOfBookingTableView.reloadData()
        print("View will appear and bookings are reloaded.")
    }
    
    // save list of bookings
    var bookings: [Booking] = []
    
    // load booking info
    
    func loadBookings() -> [Booking] {
       return []
    }
    
    func saveBookings() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
                fatalError("The dequeued cell is not an instance of CompanyTableViewCell.")
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let booking = bookings[indexPath.row]
            cell.userNameLabel.text = "\(booking.billingInfo.firstName) \(booking.billingInfo.lastName)"
            cell.originCityLabel.text = "From: \(booking.bookingInfo.originCity)"
            cell.destinationCityLabel.text = "To: \(booking.bookingInfo.destinationCity)"
            cell.departureDateLabel.text = "Depart: \( booking.bookingInfo.departureDate)"
            cell.returnDateLabel.text = "Return: \( booking.bookingInfo.returnDate)"
            
            let selectedSeats = booking.selectedSeats.filter { $0.value }.map { $0.key }.joined(separator: ", ")
            cell.selectedSeatsLabel.text = "Seats: \(selectedSeats)"
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBookingCell", for: indexPath) as? AddBookingButtonTableViewCell
            cell?.addBookingButton.setTitle("Add a Booking", for: .normal)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard indexPath.section == 0 else { return nil } // only the bookings cell has delete and update
        
        // Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            if let bookingToDelete = self?.bookings[indexPath.row]{
                
                SeatManager.shared.updateSeats(forBooking: bookingToDelete, isBookingDeleted: true)
                self?.bookings.remove(at: indexPath.row)
                self?.saveBookings() // save the updated list
                tableView.deleteRows(at: [indexPath], with: .automatic) // reflect this change with animation
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
            
        }
        
        // Update
        let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
            // Usually, you would transition to another view controller to update the selected booking
            // For now, we'll call the completion handler
            // TODO: Implement update functionality
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        updateAction.backgroundColor = .green
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    
    func printSavedBookings() {
        let defaults = UserDefaults.standard
        if let savedBookingsData = defaults.data(forKey: "Bookings") {
            do {
                let savedBookings = try JSONDecoder().decode([Booking].self, from: savedBookingsData)
                for booking in savedBookings {
                    print("Booking Info: \(booking.bookingInfo)")
                    print("Selected Seats: \(booking.selectedSeats)")
                    print("Billing Info: \(booking.billingInfo)")
                }
            } catch {
                print("Failed to decode bookings: \(error)")
            }
        } else {
            print("No bookings found in UserDefaults.")
        }
    }
    
    
}
