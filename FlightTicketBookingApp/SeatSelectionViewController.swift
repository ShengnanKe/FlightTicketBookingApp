//
//  SeatSelectionViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

// save in userdefault

import UIKit

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
        
        if let isCurrentlySelected = seatsAvailability[seatIndex], isCurrentlySelected {
            // Deselect the seat if it is already selected
            seatsAvailability[seatIndex] = false
            collectionView.reloadItems(at: [indexPath])
            print("Deselected \(seatIndex)")
        } else {
            // Select the seat if it is not selected and if the limit has not been reached
            let currentSelectedCount = seatsAvailability.values.filter { $0 }.count
            if currentSelectedCount < maxSelectableSeats {
                seatsAvailability[seatIndex] = true
                collectionView.reloadItems(at: [indexPath])
                print("Selected \(seatIndex)")
            } else {
                print("Maximum seat selection limit reached. You can only select \(maxSelectableSeats) seats.")
            }
        }
    }
    
    
    func saveSeatsAvailability() { // update SeatsAvailability as it changes
        UserDefaults.standard.set(seatsAvailability, forKey: "SeatsAvailability")
        UserDefaults.standard.synchronize()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCell", for: indexPath) as! SelectedSeatCollectionViewCell
        
        let sectionName = indexPath.section == 0 ? "First Class" : "Economy Class"
        let seatIndex = "\(indexPath.section)-\(indexPath.row)"
        let isSeatSelected = seatsAvailability[seatIndex, default: false]
        
        cell.selectedSeatLabel.text = "\(sectionName) - Seat \(indexPath.row + 1)"
        cell.backgroundColor = isSeatSelected ? UIColor.gray : UIColor.green
        cell.selectedSeatLabel.textColor = isSeatSelected ? UIColor.white : UIColor.black
        
        return cell
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all seatsAvailability into the seatsAvailability dictionary and save the selected seats
        
        saveSeatsAvailability()
        
        printCurrentSeatSelections()
        
        print("Seat selections saved successfully.")
    }
    
    func printCurrentSeatSelections() {
        for (seatIndex, isSelected) in seatsAvailability.sorted(by: { $0.key < $1.key }) {
            print("Seat \(seatIndex): \(isSelected ? "Selected" : "Not Selected")")
        }
    }
    
}
