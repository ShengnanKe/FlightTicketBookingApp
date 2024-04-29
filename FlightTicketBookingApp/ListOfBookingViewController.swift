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

struct UserBookingInfo: Codable {
    var originCity: String
    var destinationCity: String
    var departureDate: String
    var returnDate: String
    var numberOfTravelers: Int
}

struct UserBillingInfo: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var passportNumber: String
    var gender: String
    var dateOfBirth: String
    var cardName: String
    var cardNumber: String
    var expirationDate: String
    var securityCode: String
    var country: String
    var billingAddress: String
    var city: String
    var state: String
    var zipcode: String
}

struct Booking: Codable {
    var billingInfo: UserBillingInfo
    var bookingInfo: UserBookingInfo
    var selectedSeats: [String: Bool]
}

class ListOfBookingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfBookingTableView: UITableView!
    @IBOutlet weak var listOfBookingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfBookingTableView.dataSource = self
        listOfBookingTableView.delegate = self
        listOfBookingTableView.reloadData()
        // Do any additional setup after loading the view.
        
        bookings = loadBookings()
        listOfBookingTableView.reloadData()
        
        printSavedBookings()
        print("called printSavedBookings()")
    }
    
    // save list of bookings
    var bookings: [Booking] = []
    
    // load booking info
    
    func loadBookings() -> [Booking] {
        let defaults = UserDefaults.standard
        if let savedBookingsData = defaults.data(forKey: "Bookings") {
            do {
                let savedBookings = try JSONDecoder().decode([Booking].self, from: savedBookingsData)
                return savedBookings
            } catch {
                print("Failed to decode bookings: \(error)")
            }
        }
        print("No bookings found in UserDefaults.")
        return []
    }

    
    func saveBookings() {
        let defaults = UserDefaults.standard
        if let bookingsData = try? JSONEncoder().encode(bookings) {
            defaults.set(bookingsData, forKey: "Bookings")
        } else {
            print("Failed to encode bookings")
        }
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
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in let bookingToDelete = self?.bookings[indexPath.row]
            
            SeatManager.shared.updateSeats(forBooking: bookingToDelete, isBookingDeleted: true)
            self?.bookings.remove(at: indexPath.row)
            self?.saveBookings() // save the updated list
            tableView.deleteRows(at: [indexPath], with: .automatic) // reflect this change with animation
            completionHandler(true)
            
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
                    print("Billing Info: \(booking.billingInfo)")
                    print("Booking Info: \(booking.bookingInfo)")
                    print("Selected Seats: \(booking.selectedSeats)")
                }
            } catch {
                print("Failed to decode bookings: \(error)")
            }
        } else {
            print("No bookings found in UserDefaults.")
        }
    }
    
    
}
