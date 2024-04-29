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
        }
    }
    
    func saveSeats() {
        if let data = try? JSONEncoder().encode(seatsAvailability) {
            UserDefaults.standard.set(data, forKey: "SeatsAvailability")
        }
    }
    
    func updateSeats(forBooking booking: Booking, isBookingDeleted: Bool = false) {
        for (seat, isSelected) in booking.selectedSeats {
            if isBookingDeleted {
                seatsAvailability[seat] = false
            } else {
                seatsAvailability[seat] = isSelected
            }
        }
        saveSeats()
    }
    
    func loadMaximumSelectableSeats() -> Int {
        if let bookingInfoData = UserDefaults.standard.data(forKey: "BookingInfo"),
           let bookingInfo = try? JSONDecoder().decode(UserBookingInfo.self, from: bookingInfoData) {
            // Assuming `numberOfTravelers` determines the max seats selectable
            return bookingInfo.numberOfTravelers
        }
        return 0 // Default or error case
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
        
        // check and see if this seat is selected or not, and set default to fasle
        let isCurrentlySelected = seatsAvailability[seatIndex] ?? false
        
        // to change the status of the current seat
        if isCurrentlySelected {
            // If already selected, deselect it
            seatsAvailability[seatIndex] = false
            collectionView.deselectItem(at: indexPath, animated: true)
            print("De Select - \(indexPath.section)-\(indexPath.row)")
        } else {
            // If not selected, select it
            seatsAvailability[seatIndex] = true
            print("Select - \(indexPath.section)-\(indexPath.row)")
        }
        
        collectionView.reloadItems(at: [indexPath])
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
        
        // Check the seat availability and update the cell backgroundColor
        if let isSeatSelected = seatsAvailability[seatIndex], isSeatSelected {
            selectedCell.backgroundColor = UIColor.gray  // Selected
            selectedCell.selectedSeatLabel.textColor = UIColor.white
        } else {
            selectedCell.backgroundColor = UIColor.green  // Not selected
            selectedCell.selectedSeatLabel.textColor = UIColor.black
        }
        
        return selectedCell    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all seatsAvailability into the seatsAvailability dictionary
        saveSeatsAvailability()
        printCurrentSeatSelections()
    }
    
    func saveSeatsAvailability() {
        UserDefaults.standard.set(seatsAvailability, forKey: "seatsAvailability")
    }
    
    func printCurrentSeatSelections() {
        for (seatIndex, isSelected) in seatsAvailability.sorted(by: { $0.key < $1.key }) {
            print("Seat \(seatIndex): \(isSelected ? "Selected" : "Not Selected")")
        }
    }
    
}
