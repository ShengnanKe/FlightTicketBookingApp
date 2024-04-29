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
    // var seatsAvailability: [IndexPath: Bool] = [:] // [String: Bool] = [:]
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
        print("Select - \(indexPath.section)-\(indexPath.row)")
        // the specific seat section and #
        let seatIndex = "\(indexPath.section)-\(indexPath.row)" // "First Class" or "Economy Class" and it's seat #
        
        // check and see if this seat is selected or not, and set default to fasle
        let isCurrentlySelected = seatsAvailability[seatIndex] ?? false
        
        // to change the status of the current seat
        seatsAvailability[seatIndex] = !isCurrentlySelected
        
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
        
        let  seatIndex = "\(indexPath.section)-\(indexPath.row)"
        
        selectedCell.selectedSeatLabel.text = "\(sectionName) - \(indexPath.row + 1)"  // Display section and seat #
        if seatsAvailability[ seatIndex] ?? false {
            selectedCell.backgroundColor = UIColor.gray  // Selected
            selectedCell.selectedSeatLabel.textColor = UIColor.white
        } else {
            selectedCell.backgroundColor = UIColor.green  // Not selected
            selectedCell.selectedSeatLabel.textColor = UIColor.white
        }
        
        return selectedCell
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) { // to save all seatsAvailability into the seatsAvailability dictionary
        saveSeatsAvailability()
        print(saveSeatsAvailability)
    }
    
    func saveSeatsAvailability() {
        UserDefaults.standard.set(seatsAvailability, forKey: "seatsAvailability")
    }
    
}
