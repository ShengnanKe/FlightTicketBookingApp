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
    // save seats avalibility - bool - 0/1 , dict{t/f}
    var seatsAvailability: [String: Bool] = [:]
    
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

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        // apply seperator here
//        if section == 0{
//            let size : CGSize = CGSize(width: self.view.frame.width, height: 20.0)
//            return size
//        }
//        else{
//            let size : CGSize = CGSize(width: self.view.frame.width, height: 15.0)
//            return size
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 16
        }else{
            return 40
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select - \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("De Select - \(indexPath.row)")
    }
    
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
        let cell: UICollectionViewCell
        if indexPath.section == 0 { // first class
            let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCell", for: indexPath) as! SelectedSeatCollectionViewCell
            selectedCell.selectedSeatLable.text = "First Class - \(indexPath.row)"
            cell = selectedCell
        }
        else{ //econ class
            let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCell", for: indexPath) as! SelectedSeatCollectionViewCell
            selectedCell.selectedSeatLable.text = "Econ Class - \(indexPath.row)"
            cell = selectedCell
        }
        return cell
    }
    
}
