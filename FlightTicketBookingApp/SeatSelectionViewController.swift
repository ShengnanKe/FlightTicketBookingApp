//
//  SeatSelectionViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

// save in userdefault

import UIKit

class SeatManager { // for better management on the seats avaliablity
    static let shared = SeatManager()
    var seatsAvailability: [String: Bool] = [:]
    
    private init() {}
    
    func loadSeats() {
        if let data = UserDefaults.standard.data(forKey: "SeatsAvailability"),
           let availability = try? JSONDecoder().decode([String: Bool].self, from: data) {
            seatsAvailability = availability
            print("Seats loaded: \(seatsAvailability)")
        } else {
            print("Failed to load seat availability data")
        }
    }
    
    func saveSeats() {
        
    }
    
    func loadMaximumSelectableSeats() -> Int {
        if let bookingInfoData = UserDefaults.standard.data(forKey: "BookingInfo"),
           let bookingInfo = try? JSONDecoder().decode(UserBookingInfo.self, from: bookingInfoData) {
            // based on numberOfTravelers to limit how many seat the user can select
            return bookingInfo.numberOfTravelers
        }
        return 0 // Default or error case
    }
    
    func updateSeats(forBooking booking: Booking, isBookingDeleted: Bool = false) {
        for (seat, isSelected) in booking.selectedSeats {
            if isBookingDeleted {
                seatsAvailability[seat] = false // If booking is deleted, mark seats as available
            } else {
                seatsAvailability[seat] = isSelected // Update the current booking info for the update function
            }
        }
        saveSeats()
    }
}


class SeatSelectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // save seats avalibility info - bool - 0(unselected)/1(selected)
    var seatsAvailability: [String: Bool] = [:] // which section, seat# and it's selected or unselected
    
    // set up limit # on seat selections based on userinput from pervious page
    var maxSelectableSeats: Int = 0
    
    @IBOutlet weak var seatSelectionCollectionView: UICollectionView!
    // 1 way: transparent background color
    // 2 way: change icon
    // 1 collection view with 2 sections
    //@IBOutlet weak var econClassSeatSelectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seatSelectionCollectionView.delegate = self
        seatSelectionCollectionView.dataSource = self
        seatSelectionCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        // to allow de-select a cell action, I used
        seatSelectionCollectionView.allowsMultipleSelection = true
        
        self.maxSelectableSeats = SeatManager.shared.loadMaximumSelectableSeats()
        SeatManager.shared.loadSeats()
        
        self.seatsAvailability = SeatManager.shared.seatsAvailability
        
        // needed: to show updates with seats that have been selected
        seatSelectionCollectionView.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0{
            let size : CGSize = CGSize(width: self.view.frame.width, height: 100.0)
            return size
        }
        else{
            let size : CGSize = CGSize(width: self.view.frame.width, height: 10.0)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0{
            return 15.0
        }else{
            return 5.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 16
        }else{
            return 40
        }
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let seatIndex = "\(indexPath.section)-\(indexPath.row)" // 0:"First Class" or 1:"Economy Class" and it's seat #
        
        let isCurrentlySelected = seatsAvailability[seatIndex] ?? false // check and see if this seat is selected or not, and set default to fasle
        
        // to change the status of the current seat and print in the concole for confirmation
        if isCurrentlySelected {
            seatsAvailability[seatIndex] = false
            collectionView.deselectItem(at: indexPath, animated: true)
            print("De Select - \(indexPath.section)-\(indexPath.row)")
        } else {
            // Check if the maximum number of selectable seats has been reached
            let currentSelectedCount = seatsAvailability.values.filter { $0 }.count
            if currentSelectedCount < maxSelectableSeats {
                seatsAvailability[seatIndex] = true
                print("Select - \(indexPath.section)-\(indexPath.row)")
            } else {
                print("Maximum seat selection limit reached.")
                return
            }
        }
        
        SeatManager.shared.seatsAvailability = seatsAvailability
        SeatManager.shared.saveSeats()
        collectionView.reloadItems(at: [indexPath])
    }
    
    
    func saveSeatsAvailability() { // update SeatsAvailability as it changes
        SeatManager.shared.seatsAvailability = seatsAvailability
        SeatManager.shared.saveSeats()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        print("De Select - \(indexPath.section)-\(indexPath.row)")
        
        let seatIndex = "\(indexPath.section)-\(indexPath.row)"
        
        seatsAvailability[seatIndex] = false // to Deselect this seat
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    // function for seat size: differentiate the first class and economy class
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize
        if indexPath.section == 0{
            size = CGSize(width: 90, height: 120)
        }else{
            size = CGSize(width: 70, height: 140)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCell", for: indexPath) as! SelectedSeatCollectionViewCell
        
        let sectionName = indexPath.section == 0 ? "First Class" : "Economy Class"
        let seatIndex = "\(indexPath.section)-\(indexPath.row)"
        
        selectedCell.selectedSeatLabel.text = "\(sectionName) - \(indexPath.row + 1)"  // Display section and seat #
        
        
        if let isSeatSelected = seatsAvailability[seatIndex], isSeatSelected { // Check the seat availability and update the cell backgroundColor
            selectedCell.backgroundColor = UIColor.gray  // Selected
            selectedCell.selectedSeatLabel.textColor = UIColor.white
        } else {
            selectedCell.backgroundColor = UIColor.green  // Not selected
            selectedCell.selectedSeatLabel.textColor = UIColor.black
        }
        
        return selectedCell    }
    
    func saveSelectedSeats() {
        // Convert the seatsAvailability dictionary to data and save it to UserDefaults
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all seatsAvailability into the seatsAvailability dictionary and save the selected seats
        
        saveSeatsAvailability()
        
        saveSelectedSeats()
        
        printCurrentSeatSelections()
        
        print("Seat selections saved successfully.")
    }
    
    
    func printCurrentSeatSelections() {
        for (seatIndex, isSelected) in seatsAvailability.sorted(by: { $0.key < $1.key }) {
            print("Seat \(seatIndex): \(isSelected ? "Selected" : "Not Selected")")
        }
    }
    
}
